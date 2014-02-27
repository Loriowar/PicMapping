class Pic < Base

  has_many :coordinates

  attr_accessible :id,
                  :file_name,
                  :file_path,
                  :is_processed,
                  :created_at,
                  :updated_at

  validates_presence_of :file_name,
                        :file_path

  validates_uniqueness_of :file_name,
                          :file_path

  validates_length_of :file_name,
                       maximum: 255
  validates_length_of :file_path,
                      maximum: 1000

  # class methods
  class << self

    def find_and_store_pics_from_folder(folder_path, allowed_extensions = [])
      allowed_extensions += ['jpeg', 'jpg', 'png']
      fix_folder_path = folder_path
      fix_folder_path << '/' if fix_folder_path[-1] != '/'
      Dir.foreach(folder_path) do |pic_path|
        file_extension = pic_path.split('.').last
        # continue, if file have wrong extension
        next unless allowed_extensions.include?(file_extension)

        file_name = pic_path.split('/').last
        file_path = ''
        file_path << fix_folder_path
        file_path << pic_path
        # create record in db for picture
        Pic.create(file_name: file_name,
                   file_path: file_path)
      end
    end

    #get any random unprocessed picture
    def next_unmapped_record
      Pic.where(is_processed: false).order("RANDOM()").limit(1).first
    end

  end

  # instance mthods
end