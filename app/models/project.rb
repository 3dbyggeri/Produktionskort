class Project < ActiveRecord::Base
  has_many :work_processes, :dependent => :destroy
  has_many :approvals, :dependent => :destroy
  has_many :attentions, :dependent => :destroy
  has_many :companies, :dependent => :destroy
  has_many :equipment, :dependent => :destroy
  has_many :meetings, :dependent => :destroy
  has_many :people, :dependent => :destroy
  has_many :site_focuses, :dependent => :destroy
  has_many :site_operations, :dependent => :destroy
  has_many :site_responsibilities, :dependent => :destroy
  has_many :planning_referrals, :dependent => :destroy
  has_many :site_referrals, :dependent => :destroy
  
  accepts_nested_attributes_for :work_processes, 
                                :approvals, 
                                :attentions, 
                                :companies, 
                                :equipment, 
                                :meetings, 
                                :people, 
                                :site_focuses, 
                                :site_operations, 
                                :site_responsibilities, 
                                :planning_referrals, 
                                :site_referrals, :allow_destroy => true

  before_create do
    # setup fileshare
    self.fileshare_bucket = self.fileshare.bucket
  end

  def byggeweb
    @byggeweb ||= Byggeweb.new byggeweb_username, byggeweb_password, byggeweb_project
  end

  def fileshare
    @fileshare ||= Fileshare::Base.new(fileshare_bucket)
  end

  def bips_root_sections
    [
      jsonize_section("Foo"),
      jsonize_section("Bar"),
      jsonize_section("Test")
    ]
  end

  def bips_section(id)
    sections = ["Lorem Ipsum", "Overskrift A", "Test", "Punkt 1", "Endnu et punkt", "Test 123"]
    sections.map! { |name| jsonize_section name }
    sections.reject! { rand(2) == 0 }
    sections.shuffle
  end

  def bips_content(section_id)
    headlines = ["Overskrit A", "Overskrit B", "Overskrit C"]
    content = [
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nulla justo ipsum, rutrum a, consectetuer ac, malesuada vel, lacus. Vestibulum eu ligula. Vestibulum sed enim. Donec metus ante, tempor et, sollicitudin sed, consectetuer a, orci. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin volutpat. Nullam risus. Nam dignissim dolor nec urna. Quisque massa lacus, aliquet vitae, congue sed, consectetuer pharetra, ligula. In hac habitasse platea dictumst. Integer commodo sagittis felis. Vivamus et ipsum. Morbi sodales, purus hendrerit tincidunt aliquam, eros purus bibendum mi, id interdum wisi nunc sit amet tortor. Sed pharetra. Etiam laoreet arcu ut enim. In et eros. Sed vel ligula nec quam venenatis dictum. Praesent risus.",
      "Nullam justo magna, dignissim ut, ultricies eget, mollis sit amet, enim. Nulla consectetuer, dui id tempus varius, nunc libero tincidunt orci, nec fringilla eros eros in leo. Nullam vulputate tellus vel est. Donec vel urna vel metus volutpat egestas. In commodo, augue vitae pulvinar blandit, neque elit auctor metus, in bibendum magna tortor et diam. Nulla sapien. Donec ultrices felis a dui. Nam a risus in velit porttitor pretium. Quisque pharetra mi nec nulla. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.",
      "Mauris at mauris. Phasellus justo. Ut urna. Quisque pede dui, dignissim a, ullamcorper et, bibendum vitae, sapien. Proin ut diam. Aenean purus. Ut ante. Mauris consectetuer lectus at est. Nam id leo. Maecenas at eros. In lectus pede, porttitor eu, imperdiet sed, malesuada sed, dui. Suspendisse venenatis, justo nec dapibus bibendum, odio eros ultricies nisl, in porta quam libero vitae erat. Aenean imperdiet tempus elit. Phasellus pellentesque mauris non velit facilisis egestas. Proin ultrices, dolor eu rutrum ullamcorper, velit odio bibendum turpis, in accumsan massa elit nec nulla. Vivamus lacus. Proin accumsan. Nullam magna.",
      "Morbi tellus tortor, adipiscing vel, rutrum quis, tempus vitae, purus. Etiam lorem eros, fermentum vitae, euismod ut, varius porta, lorem. In quis diam. Cras scelerisque. Cras pharetra massa id ligula. Ut tortor. Aenean ipsum nunc, rhoncus vel, sagittis non, luctus sed, est. Integer condimentum. Ut nonummy, orci eget iaculis semper, sem sapien mollis ante, ac hendrerit lacus lacus eget tellus. Phasellus scelerisque tempor sapien. Nulla facilisi. Curabitur sagittis pretium lectus. Sed a ante. Aliquam erat volutpat. Quisque hendrerit sem eu odio. Duis rhoncus. Vestibulum scelerisque tortor ut nulla. Mauris risus massa, nonummy in, tincidunt eget, imperdiet eget, massa. Pellentesque at ligula.",
      "Nunc lobortis ligula a wisi lobortis lacinia. Cras ut diam. Nam interdum, erat id venenatis convallis, neque elit viverra nisl, in ultrices est odio non arcu. Fusce interdum consequat massa. Mauris interdum. Nunc sagittis ultrices justo. Praesent sagittis. Praesent quis neque non mi imperdiet dictum. Aliquam dictum luctus neque. Morbi lobortis. Fusce consequat fermentum nisl. Praesent vestibulum. Proin pretium tempus elit."
    ]
    content.map! { |content| { :headline => headlines[rand(3)], :body => content, :id => rand(1024) } }
    content[rand(5)]
  end

  # when generating dummy nodes, you can leave the ID blank to get a random ID
  def jsonize_section(name, id = nil, open = false, children = [])
    {
      :data => {
        :title => name,
        :attr => { :class => 'tree-node' }
      },
      :attr => { :rel => id || rand(1024) },
      :state => (open ? 'open' : 'closed'),
      :children => children
    }
  end

  def to_xml(options = {}, &block)
    options[:except].concat([:byggeweb_project, :byggeweb_username, :byggeweb_password]).uniq!
    super
  end

  def to_json(options = {})
    options[:except].concat([:byggeweb_project, :byggeweb_username, :byggeweb_password]).uniq!
    super
  end

  def to_xml_deep
    to_xml(
      :include => {
        :approvals => {},
        :attentions => {},
        :companies => {},
        :equipment => {},
        :meetings => {},
        :people => {},
        :site_focuses => {},
        :site_operations => {},
        :site_responsibilities => {},
        :planning_referrals => {},
        :site_referrals => {}
      }
    )
  end
end
