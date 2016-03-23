class Article < ActiveRecord::Base
  WillPaginate.per_page = 10

  validates :title, presence: true,
    length: { minimum: 5 }
  validates :content, presence: true,
    length: { minimum: 10 }
  validates :status, presence: true

  validates_presence_of :title

  scope :status_active, -> {where(status: 'active')}

  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :comments,
                                    reject_if: proc { |attributes| attributes['content'].blank? },
                                     allow_destroy: true
  validates :content,
    presence: true
  def to_s
    content
  end

  def self.search(search)
    if search
      where(["title LIKE ?","%#{search}%"])
    else
      all
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |article|
        csv << article.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    allowed_attributes = [ "id","title","content","status","created_at","updated_at"]
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      article = find_by_id(row["id"]) || new
      article.attributes = row.to_hash.select { |k,v| allowed_attributes.include? k }
      article.save!
    end
    # CSV.foreach(file.path, headers: true) do |row|
    #   Article.create! row.to_hash
    # end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
