class Department < ActiveRecord::Base

  validates_presence_of :name, :abbr
  #validates_uniqueness_of :name
  validates_uniqueness_of :abbr

  def Department.init
    #if all.empty?
      @@base.each_pair do |name, abbr|
        Department.create(:name => name, :abbr => abbr)
      end
    #end
  end
end

private
# from http://registrar.berkeley.edu/?PageID=deptabb.html
  @@base = {
    "Computer Science" => "compsci",
    "Gender and Women's Studies" => "gws",
    "Aerospace Studies (Air Force ROTC)" => "aerospc",
    "Math" => "math",
    "African American Studies" => "african",
    "Agricultural and Environmental Chemistry" => "agr chm",
    "Environmental Economics and Policy" => "envecon",
    "Agricultural and Resource Economics and Policy" => "a,resec",
    "American Studies" => "amerstd",
    "Ancient History and Mediterranean Archaeology" => "ahma",
    "Anthropology" => "anthro",
    "Applied Science and Technology" => "ast",
    "Architecture" => "arch",
    "Visual Studies" => "vis std",
    "Practice of Art" => "art",
    "History of Art" => "histart",
    "Asian American Studies Program" =>	"asamst",
    "Asian Studies" => "asianst",
    "Astronomy" => "astron",
    "Bioengineering" => "bio eng",
    "Biology" => "biology",
    "Biophysics" =>	"biophy",
    "Buddhist Studies" =>	"buddstd",
    "Business Administration" => "bus adm",
    "Full-time Masters in Business Administration" => "mba"
  }