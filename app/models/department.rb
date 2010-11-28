class Department < ActiveRecord::Base
  include ApplicationHelper
  
  validates_presence_of :name, :abbr
  validates_uniqueness_of :name
  validates_uniqueness_of :abbr

  has_many :courses

  before_save { |d| d.name = d.name.titleizev2; d.abbr = d.abbr.upcase }
end
#
#Full-time Masters in Business Administration  	mba  	Show  	Edit  	Destroy
#Bioengineering 	bio eng 	Show 	Edit 	Destroy
#Asian Studies 	asianst 	Show 	Edit 	Destroy
#Practice of Art 	art 	Show 	Edit 	Destroy
#American Studies 	amerstd 	Show 	Edit 	Destroy
#Gender and Women's Studies 	gws 	Show 	Edit 	Destroy
#Computer Science 	compsci 	Show 	Edit 	Destroy
#Business Administration 	bus adm 	Show 	Edit 	Destroy
#Biophysics 	biophy 	Show 	Edit 	Destroy
#Applied Science and Technology 	ast 	Show 	Edit 	Destroy
#Astronomy 	astron 	Show 	Edit 	Destroy
#Agricultural and Environmental Chemistry 	agr chm 	Show 	Edit 	Destroy
#Agricultural and Resource Economics and Policy 	a,resec 	Show 	Edit 	Destroy
#Buddhist Studies 	buddstd 	Show 	Edit 	Destroy
#Ancient History and Mediterranean Archaeology 	ahma 	Show 	Edit 	Destroy
#Anthropology 	anthro 	Show 	Edit 	Destroy
#African American Studies 	african 	Show 	Edit 	Destroy
#Math 	math 	Show 	Edit 	Destroy
#Biology 	biology 	Show 	Edit 	Destroy
#Asian American Studies Program 	asamst 	Show 	Edit 	Destroy
#Visual Studies 	vis std 	Show 	Edit 	Destroy
#Environmental Economics and Policy 	envecon 	Show 	Edit 	Destroy
#History of Art 	histart 	Show 	Edit 	Destroy
#Architecture 	arch 	Show 	Edit 	Destroy
#Aerospace Studies (Air Force ROTC) 	aerospc 	Show 	Edit 	Destroy