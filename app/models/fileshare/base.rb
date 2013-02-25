# coding: utf-8
module Fileshare
  class Base
    attr_reader :prefix
    attr_reader :bucket

    def initialize(prefix)
      @prefix = prefix
      @bucket = case Rails.env
        when "development" then "development-bb559243a8067d77c669d1cd129c17e5"
        when "production"  then "production-5690de0c11e938105fe5d662f0e12afa"
        else raise "Bucket not configured for #{Rails.env} environment"
        end

      Rails.logger.debug "[FILESHARE] Connecting to S3..."
      AWS::S3::Base.establish_connection!(
        :access_key_id     => ENV['S3_KEY'],
        :secret_access_key => ENV['S3_SECRET']
      )

      check_create_default_folders

      Rails.logger.debug "[FILESHARE] Using S3 bucket #{@bucket} / #{@prefix}"
    end

    def folders(path = '')
      Rails.logger.debug "[FILESHARE] Loading sub-folders for #{path}"
      Folders.new folder(path).select { |k| k =~ /_\$folder\$$/ }.map { |k| k.sub(/_\$folder\$$/, '') }
    end

    def files(path = '')
      Rails.logger.debug "[FILESHARE] Loading files in #{path}"
      Files.new folder(path).select { |k| k !~ /_\$folder\$$/ }
    end

    def file(key)
      filename = key.split('/').last
      file = AWS::S3::S3Object.find(key, @bucket)
      Rails.logger.debug "[FILESHARE] Importing attachment #{file.key}"

      attachment = StringIO.new file.value
      attachment.instance_eval <<-RUBY
        def original_filename
          '#{filename}'
        end
      RUBY

      return attachment
    end

    private

    def check_create_default_folders
      return unless folders().size == 0
      create_default_folders
    end

    def folder(path)
      # make sure the path ends with a /
      path += '/' if !path.blank? && path !~ /\/$/
      path = File.join(@prefix, path)

      # only the keys that matches the path
      keys = AWS::S3::Bucket.objects(@bucket, :prefix => path).map(&:key)
      # remove the base of the key
      keys.map! { |k| k.force_encoding('UTF-8').sub(/^#{path.gsub('/', '\/')}/, '') }
      # ignore sub-folders
      keys.select { |k| k !~ /\// }
    end

    def create_default_folders
      AWS::S3::S3Object.store "#{@prefix}_$folder$", nil, @bucket
      DEFAULT_FOLDERS.each do |folder|
        folder = File.join(@prefix, folder)
        AWS::S3::S3Object.store folder, nil, @bucket
      end
    end

    DEFAULT_FOLDERS = [
      '01 SAGSBASIS_$folder$',
      '01 SAGSBASIS/01-01 Sagsregistrering_$folder$',
      '01 SAGSBASIS/01-01 Sagsregistrering/01 Scannede tegninger_$folder$',
      '01 SAGSBASIS/01-01 Sagsregistrering/02 Digitale tegninger_$folder$',
      '01 SAGSBASIS/01-01 Sagsregistrering/03 Foto_$folder$',
      '01 SAGSBASIS/01-01 Sagsregistrering/04 Registrering og Tilstand_$folder$',
      '01 SAGSBASIS/01-01 Sagsregistrering/05 Byggeprogram_$folder$',
      '01 SAGSBASIS/01-01 Sagsregistrering/09 Øvrige_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer/Anlæg_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer/El_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer/Gulve_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer/Jord & Beton_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer/Maler_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer/Murer_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer/Stål_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer/Tømrer_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer/Ventilation_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Projektafklaringer/VVS_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater/Anlæg_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater/El_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater/Gulve_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater/Jord & Beton_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater/Maler_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater/Murer_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater/Stål_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater/Tømrer_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater/Ventilation_$folder$',
      '01 SAGSBASIS/01-02 Projektplanlægning/Tilsynsnotater/VVS_$folder$',
      '01 SAGSBASIS/01-03 Tidsplan_$folder$',
      '01 SAGSBASIS/01-03 Tidsplan/Detailtidsplaner_$folder$',
      '01 SAGSBASIS/01-03 Tidsplan/Forhindringslister_$folder$',
      '01 SAGSBASIS/01-03 Tidsplan/Forhindringslister/Arkitekt_$folder$',
      '01 SAGSBASIS/01-03 Tidsplan/Forhindringslister/Ingeniør_$folder$',
      '01 SAGSBASIS/01-03 Tidsplan/Forhindringslister/Hovedtidsplan_$folder$',
      '01 SAGSBASIS/01-04 Referater_$folder$',
      '01 SAGSBASIS/01-04 Referater/Byggemøder_$folder$',
      '01 SAGSBASIS/01-04 Referater/Opstartsmøder_$folder$',
      '01 SAGSBASIS/01-04 Referater/Projekteringsmøder_$folder$',
      '01 SAGSBASIS/01-04 Referater/Sikkerhedsmøder_$folder$',
      '01 SAGSBASIS/01-04 Referater/Tidsplansmøder_$folder$',
      '01 SAGSBASIS/01-05 PSS_$folder$',
      '02 Jakon_$folder$',
      '02 Jakon/D&V_$folder$',
      '02 Jakon/Foto-Video_$folder$',
      '02 Jakon/Kalkkulationer_$folder$',
      '02 Jakon/Kvalitetssikring_$folder$',
      '02 Jakon/Overdragelse_$folder$',
      '02 Jakon/Sikkerhedsmappen_$folder$',
      '02 Jakon/Sikkerhedsmappen/APV_$folder$',
      '02 Jakon/Sikkerhedsmappen/Maskinbrugsanvisninger_$folder$',
      '02 Jakon/Sikkerhedsmappen/PSS_$folder$',
      '02 Jakon/Tjeklister_$folder$',
      '07 TEGNINGER_$folder$',
      '07 TEGNINGER/07-01 Bygherre_$folder$',
      '07 TEGNINGER/07-01 Bygherre01 Tegningsliste_$folder$',
      '07 TEGNINGER/07-01 Bygherre02 Skitse_$folder$',
      '07 TEGNINGER/07-01 Bygherre03 Fagmodel_$folder$',
      '07 TEGNINGER/07-01 Bygherre04 Tegning_$folder$',
      '07 TEGNINGER/07-01 Bygherre05 Plot_$folder$',
      '07 TEGNINGER/07-02 Bygherre RÅD_$folder$',
      '07 TEGNINGER/07-02 Bygherre RÅD/01 Tegningsliste_$folder$',
      '07 TEGNINGER/07-02 Bygherre RÅD/02 Skitse_$folder$',
      '07 TEGNINGER/07-02 Bygherre RÅD/03 Fagmodel_$folder$',
      '07 TEGNINGER/07-02 Bygherre RÅD/04 Tegning_$folder$',
      '07 TEGNINGER/07-02 Bygherre RÅD/05 Plot_$folder$',
      '07 TEGNINGER/07-03 Arkitekt_$folder$',
      '07 TEGNINGER/07-03 Arkitekt/01 Tegningsliste_$folder$',
      '07 TEGNINGER/07-03 Arkitekt/02 Skitse_$folder$',
      '07 TEGNINGER/07-03 Arkitekt/03 Planer_$folder$',
      '07 TEGNINGER/07-03 Arkitekt/04 Facader og opstalter_$folder$',
      '07 TEGNINGER/07-03 Arkitekt/05 Rumtegninger_$folder$',
      '07 TEGNINGER/07-03 Arkitekt/06 Bygningsdele_$folder$',
      '07 TEGNINGER/07-03 Arkitekt/07 Snit_$folder$',
      '07 TEGNINGER/07-03 Arkitekt/08 Diverse_$folder$',
      '07 TEGNINGER/07-04 Arkitekt LAND_$folder$',
      '07 TEGNINGER/07-04 Arkitekt LAND/01 Tegningsliste_$folder$',
      '07 TEGNINGER/07-04 Arkitekt LAND/02 Skitse_$folder$',
      '07 TEGNINGER/07-04 Arkitekt LAND/03 Fagmodel_$folder$',
      '07 TEGNINGER/07-04 Arkitekt LAND/04 Tegning_$folder$',
      '07 TEGNINGER/07-04 Arkitekt LAND/05 Plot_$folder$',
      '07 TEGNINGER/07-05 Ingeniør KON_$folder$',
      '07 TEGNINGER/07-05 Ingeniør KON/01 Tegningsliste_$folder$',
      '07 TEGNINGER/07-05 Ingeniør KON/02 Skitse_$folder$',
      '07 TEGNINGER/07-05 Ingeniør KON/03 Fagmodel_$folder$',
      '07 TEGNINGER/07-05 Ingeniør KON/04 Tegning_$folder$',
      '07 TEGNINGER/07-05 Ingeniør KON/05 Plot_$folder$',
      '07 TEGNINGER/07-06 Ingeniør VVS og VENT_$folder$',
      '07 TEGNINGER/07-06 Ingeniør VVS og VENT/01 Tegningsliste_$folder$',
      '07 TEGNINGER/07-06 Ingeniør VVS og VENT/02 Skitse_$folder$',
      '07 TEGNINGER/07-06 Ingeniør VVS og VENT/03 Fagmodel_$folder$',
      '07 TEGNINGER/07-06 Ingeniør VVS og VENT/04 Tegning_$folder$',
      '07 TEGNINGER/07-06 Ingeniør VVS og VENT/05 Plot_$folder$',
      '07 TEGNINGER/07-07 Ingeniør EL og CTS_$folder$',
      '07 TEGNINGER/07-07 Ingeniør EL og CTS/01 Tegningsliste_$folder$',
      '07 TEGNINGER/07-07 Ingeniør EL og CTS/02 Skitse_$folder$',
      '07 TEGNINGER/07-07 Ingeniør EL og CTS/03 Fagmodel_$folder$',
      '07 TEGNINGER/07-07 Ingeniør EL og CTS/04 Tegning_$folder$',
      '07 TEGNINGER/07-07 Ingeniør EL og CTS/05 Plot_$folder$',
      '07 TEGNINGER/07-08 Entreprenør_$folder$',
      '07 TEGNINGER/07-08 Entreprenør/01 Tegningsliste_$folder$',
      '07 TEGNINGER/07-08 Entreprenør/02 Skitse_$folder$',
      '07 TEGNINGER/07-08 Entreprenør/03 Fagmodel_$folder$',
      '07 TEGNINGER/07-08 Entreprenør/04 Tegning_$folder$',
      '07 TEGNINGER/07-08 Entreprenør/05 Plot_$folder$',
      '07 TEGNINGER/07-09 SYMBOLER_$folder$',
      '07 TEGNINGER/07-10 FÆLLESMODEL_$folder$',
      '07 TEGNINGER/07-11 KONSISTENSKONTROL_$folder$',
      '07 TEGNINGER/07-12 VISUALISERING_$folder$',
      '08 BESKRIVELSER_$folder$',
      '08 BESKRIVELSER/08-01 Rumskema_$folder$',
      '08 BESKRIVELSER/08-02 Materialedata_$folder$',
      '08 BESKRIVELSER/08-03 Byggesagsbeskrivelse_$folder$',
      '08 BESKRIVELSER/08-04 Arbejdsbeskrivelser_$folder$',
      '08 BESKRIVELSER/08-05 BIPS Basisbeskrivelser_$folder$',
      '09 BEREGNINGER_$folder$',
      '09 BEREGNINGER/09-01 Bygherre_$folder$',
      '09 BEREGNINGER/09-02 Bygherre RÅD_$folder$',
      '09 BEREGNINGER/09-03 Arkitekt_$folder$',
      '09 BEREGNINGER/09-04 Arkitekt LAND_$folder$',
      '09 BEREGNINGER/09-05 Ingeniør KON_$folder$',
      '09 BEREGNINGER/09-06 Ingeniør VVS og VENT_$folder$',
      '09 BEREGNINGER/09-07 Ingeniør EL og CTS_$folder$',
      '09 BEREGNINGER/09-08 Landinspektør_$folder$',
      '09 BEREGNINGER/09-09 Øvrige_$folder$',
      '10 Leverandørprojektering_$folder$',
      '10 Leverandørprojektering/Betonelementer_$folder$',
      '10 Leverandørprojektering/Stål_$folder$',
      '11 Levenrandør og Montagevejledninger_$folder$',
      '11 Levenrandør og Montagevejledninger/Carl F_$folder$',
      '11 Levenrandør og Montagevejledninger/Carl Ras_$folder$',
      '11 Levenrandør og Montagevejledninger/Danogips_$folder$',
      '11 Levenrandør og Montagevejledninger/Rockfon_$folder$',
      '11 Levenrandør og Montagevejledninger/Stark_$folder$'
    ]
  end
end
