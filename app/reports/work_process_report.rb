# coding: utf-8
class WorkProcessReport < Prawn::Document
  def initialize(work_process, table_of_content, options = {})
    options = {:page_size => 'A4', :top_margin => 150, :right_margin => 120, :bottom_margin => 150, :left_margin => 120}.merge(options)

    super options do |pdf|
      # *****************************************************************
      # *****************************************************************
      # *****************************************************************
      pdf.stroke_color 'c1002b'
      # *****************************************************************

      pdf.image "#{Rails.root}/assets/jakon_logo.png", :position => :right, :width => 100
      pdf.move_down 20
      pdf.text "Svendemappe\n#{work_process.project.name}\n#{work_process.project.address}", :size => 28, :leading => 5
      pdf.move_down 30
      pdf.text "Sagsnr.: #{work_process.activity_number}", :size => 16
      pdf.move_down 10
      pdf.image "#{Rails.root}/assets/jakon_fp.jpg", :position => :center, :width => 335
      pdf.move_down 25
      pdf.text I18n.l(Date.today, :format => :long), :size => 16
      pdf.stroke do
        pdf.move_down 5
        pdf.horizontal_rule
        pdf.move_down 20
      end
      pdf.text work_process.component_type, :size => 14, :leading => 5
      pdf.text "• #{work_process.activity} #{work_process.activity_number ? "(#work_process.activity_number)" : ''}", :leading => 5
      pdf.text "• #{work_process.location}", :leading => 5
      # pdf.text "• Etape", :leading => 5
      # pdf.text "• Område", :leading => 5
      # pdf.text "• Afsnit", :leading => 5
      # pdf.text "• Personer", :leading => 5
      pdf.text "JAKON", :align => :right, :valign => :bottom, :style => :bold, :character_spacing => 1

      # *****************************************************************
      # *****************************************************************
      # *****************************************************************
      pdf.start_new_page :top_margin => 450, :right_margin => 230
      # *****************************************************************

      pdf.indent(20) do
        pdf.image "#{Rails.root}/assets/jakon_logo.png", :width => 100
      end
      pdf.move_down 60
      pdf.text "JAKON", :style => :bold, :character_spacing => 1
      pdf.stroke do
        pdf.move_down 5
        pdf.horizontal_rule
        pdf.move_down 40
      end
      pdf.text "Baltorpbakken 9\n2750 Ballerup", :leading => 5
      pdf.move_down 10
      pdf.text "Telefon: 44 83 02 00\nFax: 44 83 02 20\nE-mail: jakon@jakon.dk", :leading => 5

      # *****************************************************************
      # *****************************************************************
      # *****************************************************************
      pdf.start_new_page :top_margin => 100, :right_margin => 70, :bottom_margin => 100, :left_margin => 70
      pdf.font_size = 10
      # *****************************************************************

      table_of_content.each_index { |i| table_of_content[i] = [(i+1).to_s, table_of_content[i]] }
      pdf.table(table_of_content, :cell_style => { :borders => [] }) do
        column(0).style do |c|
          c.align = :right
          c.size = 16
          c.padding = [5,10,5,0]
        end
        column(1).style do |c|
          c.size = 16
        end
      end
      pdf.image "#{Rails.root}/assets/spaane3.png", :position => :right, :width => 75, :at => [pdf.bounds.right-75, 0]

      # *****************************************************************
      # *****************************************************************
      # *****************************************************************
      pdf.start_new_page :top_margin => 50, :right_margin => 30, :bottom_margin => 30, :left_margin => 30, :layout => :landscape
      pdf.stroke_color '000000'
      pdf.define_grid :columns => 3, :rows => 1, :column_gutter => 10
      # *****************************************************************

      left = pdf.grid 0,0
      pdf.bounding_box left.top_left, :width => left.width, :height => left.height do
        pdf.text 'Personer', :size => 14
        unless work_process.project.people.empty?
          pdf.table work_process.project.people.map { |p| [p.kind, p.name, p.mobile_tel] }, :cell_style => { :borders => [], :padding => [0,10,0,0] }
        end

        pdf.divider

        pdf.text 'Byggeplads bemærkninger', :size => 14
        list_items = []
        (work_process.project.site_focuses + work_process.project.site_operations).each do |remark|
          list_items << "#{remark.description} (#{remark.kind})"
        end
        pdf.unordered_list list_items

        pdf.divider

        pdf.text 'Planlægning', :size => 14
        pairs = []
        pairs << ['Planlagt start', work_process.planned_start.to_s(:short)] unless work_process.planned_start.blank?
        pairs << ['Planlagt slut', work_process.planned_end.to_s(:short)] unless work_process.planned_end.blank?
        pairs << ['Forudgående', work_process.preceding]
        pairs << ['Efterfølgende', work_process.subsequent]
        pdf.definition_list pairs

        pdf.divider

        pdf.text 'Montage', :size => 14
        pairs = []
        pairs << ['Placering', work_process.location]
        pairs << ['Levering senest', work_process.project_delivery_time]
        pairs << ['Ansvarlig', work_process.project_delivery_person]
        pairs << [work_process.unit, work_process.value] unless work_process.unit.blank?
        pdf.definition_list pairs

        pdf.divider

        pdf.text 'Krav', :size => 14
        list_items = []
        work_process.requirements.each do |requirement|
          elements = []
          elements << requirement.kind
          elements << "#{requirement.component}:" unless requirement.component.blank? 
          elements << requirement.description unless requirement.description.blank?
          list_items << elements.join(' ')
        end
        pdf.unordered_list list_items

        pdf.divider

        pdf.text 'Værnemidler', :size => 14
        list_items = []
        work_process.protections.each do |protection|
          elements = []
          elements << protection.kind
          elements << protection.notes unless protection.notes.blank? 
          elements << protection.usage unless protection.usage.blank?
          list_items << elements.join(' ')
        end
        pdf.unordered_list list_items
      end

      right = pdf.grid 0,1
      pdf.bounding_box right.top_left, :width => right.width, :height => right.height do
        pdf.text 'Process specifikt materiel', :size => 14
        list_items = []
        work_process.equipment.each { |equipment| list_items << "#{equipment.kind}: #{equipment.notes}" }
        pdf.unordered_list list_items

        pdf.divider

        pdf.text 'Materialer', :size => 14
        work_process.material_packages.each do |material_package|
          pdf.text "Materialepakke, unitnr.: #{material_package.unit_number}"
          pdf.table material_package.materials.map { |m| [m.kind, m.count, m.weight, m.measures, "#{m.lengths} #{m.unit}"] }, :cell_style => { :borders => [], :padding => [0,8,0,0] } do
            column(1).style { |c| c.align = :right }
            column(2).style { |c| c.align = :right }
            column(3).style { |c| c.align = :right }
            column(4).style { |c| c.align = :right }
          end
        end

        pdf.divider

        pdf.text 'Mandskab', :size => 14
        pairs = []
        pairs << ['Ansvarlig', work_process.responsible] unless work_process.responsible.blank?
        pairs << ['Varighed (timer)', work_process.duration] unless work_process.duration.blank?
        pairs << ['Akkord', work_process.piecework_rate] unless work_process.piecework_rate.blank?
        pairs << ['Timeløn', work_process.hourly_rate] unless work_process.hourly_rate.blank?
        pairs << ['Bonus', work_process.bonus ? "Ja" : "Nej"]
        pairs << ['Incitamentaftale', work_process.incentive_deal ? "Ja" : "Nej"]
        pairs << ['Godtgørelse', work_process.allowance] unless work_process.allowance.blank?
        pairs << ['Tid på dagen', work_process.time_of_day] unless work_process.time_of_day.blank?
        pairs << ['Ekstraarbejde', work_process.extra_work ? "Ja" : "Nej"]
        pdf.definition_list pairs

        pdf.divider

        pdf.text 'Kompetencer', :size => 14
        list_items = []
        work_process.qualifications.each do |qualification|
          elements = []
          elements << "#{qualification.kind}:"
          elements << qualification.notes unless qualification.notes.blank?
          elements << "(Immatriel møntfod #{qualification.immaterial_currency})" unless qualification.immaterial_currency.blank?
          list_items << elements.join(' ')
        end
        pdf.unordered_list list_items
      end
    end
  end

  def divider
    self.stroke do
      self.move_down 10
      self.horizontal_rule
      self.move_down 15
    end
  end

  def unordered_list(elements = [])
    self.table elements.map { |element| ["•", element] }, :cell_style => { :borders => [], :padding => 0 }, :column_widths => { 0 => 7 }
  end

  def definition_list(pairs = [])
    self.table pairs, :cell_style => { :borders => [], :padding => [0,8,0,0] }
  end
end