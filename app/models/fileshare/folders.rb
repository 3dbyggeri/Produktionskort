module Fileshare
  class Folders < Array
    def to_json(wrapper_node = nil)
      folders = map { |name| jsonize_folder name }

      if wrapper_node
        jsonize_folder wrapper_node, folders
      else
        folders
      end
    end

    private

    def jsonize_folder(name, children = [])
      {
        :data => {
          :title => name,
          :attr => { :class => 'tree-node' }
        },
        :state => (children.empty? ? 'closed' : 'open'),
        :children => children
      }
    end
  end
end
