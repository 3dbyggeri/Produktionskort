# coding: utf-8
class PdfsController < ApplicationController
  def new
    @work_process = WorkProcess.find(params[:work_process_id])
  end

  def create
    @work_process = WorkProcess.find(params[:work_process_id])

    produktionskort = Prawn::Document.new :page_size => 'A4' do |pdf|
      pdf.define_grid :columns => 2, :rows => 1, :column_gutter => 10

      pdf.text @work_process.activity, :align => :center, :size => 22

      left = pdf.grid 0,0
      pdf.bounding_box left.top_left, :width => left.width, :height => left.height do
        pdf.move_down 30

        pdf.text "#{@work_process.project.title_number} #{@work_process.project.name}"
        pdf.move_down 5
        pdf.text 'Adresse', :size => 14
        pdf.text @work_process.project.address
        pdf.move_down 8
        pdf.text 'Personer', :size => 14
        pdf.table @work_process.project.people.map { |p| [p.kind, p.name, p.mobile_tel] }

        pdf.stroke do
          pdf.move_down 10
          pdf.horizontal_rule
          pdf.move_down 10
        end

        pdf.move_down 5
        pdf.text 'Byggeplads bemærkninger', :size => 14
        (@work_process.project.site_focuses + @work_process.project.site_operations).each do |remark|
          pdf.text "#{remark.description} (#{remark.kind})"
        end

        pdf.stroke do
          pdf.move_down 10
          pdf.horizontal_rule
          pdf.move_down 10
        end

        pdf.move_down 5
        pdf.text 'Planlægning og opfølgning', :size => 14
        table = []
        table << ['Planlagt start', @work_process.planned_start.to_s(:short)] unless @work_process.planned_start.blank?
        table << ['Planlagt slut', @work_process.planned_end.to_s(:short)] unless @work_process.planned_end.blank?
        table << ['Forudgående', @work_process.preceding]
        table << ['Efterfølgende', @work_process.subsequent]
        pdf.table table

        pdf.stroke do
          pdf.move_down 10
          pdf.horizontal_rule
          pdf.move_down 10
        end

        pdf.move_down 5
        pdf.text 'Montage', :size => 14
        table = []
        table << ['Placering', @work_process.location]
        table << ['Levering senest', @work_process.project_delivery_time.to_s(:short)] unless @work_process.project_delivery_time.blank?
        table << ['Ansvarlig', @work_process.project_delivery_person]
        table << [@work_process.unit, @work_process.value] unless @work_process.unit.blank?
        pdf.table table
      end

      right = pdf.grid 0,1
      pdf.bounding_box right.top_left, :width => right.width, :height => right.height do
        pdf.move_down 30

        pdf.move_down 5
        pdf.text 'Krav', :size => 14
        @work_process.requirements.each do |requirement|
          elements = []
          elements << requirement.kind
          elements << "#{requirement.component}:" unless requirement.component.blank? 
          elements << requirement.description unless requirement.description.blank?
          pdf.text elements.join(' ')
        end

        pdf.stroke do
          pdf.move_down 10
          pdf.horizontal_rule
          pdf.move_down 10
        end

        pdf.move_down 5
        pdf.text 'Værnemidler', :size => 14
        @work_process.protections.each do |protection|
          elements = []
          elements << protection.kind
          elements << protection.notes unless protection.notes.blank? 
          elements << protection.usage unless protection.usage.blank?
          pdf.text elements.join(' ')
        end

        pdf.stroke do
          pdf.move_down 10
          pdf.horizontal_rule
          pdf.move_down 10
        end

        pdf.move_down 5
        pdf.text 'Process specifikt materiel', :size => 14
        @work_process.equipment.each { |equipment| pdf.text "#{equipment.kind}: #{equipment.notes}" }

        pdf.stroke do
          pdf.move_down 10
          pdf.horizontal_rule
          pdf.move_down 10
        end

        pdf.move_down 5
        pdf.text 'Materialer', :size => 14
        @work_process.material_packages.each do |material_package|
          pdf.text "Materialepakke, unitnr.: #{material_package.unit_number}"
          pdf.table material_package.materials.map { |m| [m.kind, m.count, m.weight, m.measures, "#{m.lengths} #{m.unit}"] }
        end


        pdf.stroke do
          pdf.move_down 10
          pdf.horizontal_rule
          pdf.move_down 10
        end

        pdf.move_down 5
        pdf.text 'Mandskab', :size => 14
        table = []
        table << ['Socialt ansvar', @work_process.social_responsibility] unless @work_process.social_responsibility.blank?
        table << ['Akkord', @work_process.piecework_rate] unless @work_process.piecework_rate.blank?
        table << ['Timeløn', @work_process.hourly_rate] unless @work_process.hourly_rate.blank?
        table << ['Bonus', @work_process.bonus ? "Ja" : "Nej"]
        table << ['Incitamentaftale', @work_process.incentive_deal ? "Ja" : "Nej"]
        table << ['Godtgørelse', @work_process.allowance] unless @work_process.allowance.blank?
        table << ['Tid på dagen', @work_process.time_of_day] unless @work_process.time_of_day.blank?
        table << ['Ekstra arbejde', @work_process.extra_work ? "Ja" : "Nej"]
        pdf.table table

        pdf.stroke do
          pdf.move_down 10
          pdf.horizontal_rule
          pdf.move_down 10
        end

        pdf.move_down 5
        pdf.text 'Kompetencer', :size => 14
        @work_process.qualifications.each do |qualification|
          elements = []
          elements << "#{qualification.kind}:"
          elements << qualification.notes unless qualification.notes.blank?
          elements << "(Immatriel møntfod #{qualification.immaterial_currency})" unless qualification.immaterial_currency.blank?
          pdf.text elements.join(' ')
        end
      end
    end.render

    # send_data produktionskort, :type => 'application/pdf',
    #                            :disposition => 'inline',
    #                            :filename => 'produktionskort.pdf'

    file = Tempfile.new "produktionskort.zip"
    Zip::ZipOutputStream.open(file.path) do |zip|
      filename = "#{@work_process.component_type.blank? ? 'Produktionskort' : @work_process.component_type}.pdf"
      zip.put_next_entry "produktionskort/#{filename}"
      zip.print produktionskort
      zip.put_next_entry 'produktionskort/Se produktionskort online.url'
      zip.print "[InternetShortcut]\nURL=#{work_process_url(@work_process)}\n"
      params['attachments'].try(:each) do |url|
        url, filename = process_url(url)
        zip.put_next_entry "produktionskort/bilag/#{filename}"
        zip.print open(url) {|f| f.read }
      end
    end
    file.close

    filename = "#{Rails.root}/public/robots.txt"
    Rails.logger.error "--> #{File.exist?(filename)}: #{filename}"
    file = File.new(filename)
    Rails.logger.error "--> #{file.size}"

    send_file file.path, :type => 'text/plan',
                         :disposition => 'attachment',
                         :filename => 'produktionskort.txt'
  end

  private

  def process_url(url)
    @used_filenames ||= ['produktionskort.pdf']
    filename = url.split('/').last.sub(/\?\d+$/, '')

    if @used_filenames.include?(filename)
      extname = File.extname(filename)
      basename = File.basename(filename, extname)
      n = 1
      while @used_filenames.include?(filename)
        n =+ 1
        filename = "#{basename}#{n}#{extname}"
      end
    end

    @used_filenames << filename

    return [url, filename]
  end
end