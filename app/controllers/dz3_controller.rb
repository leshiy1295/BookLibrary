require 'digest/md5'
class Dz3Controller < ApplicationController
  skip_before_filter :require_login, :only=> [:poisk, :show]
  def poisk
	find_item=params[:form][:find_item]
	find_category=params[:form][:find_category].to_i
	case find_category
		when 1
			@result=Bibl.where(:title=>find_item.downcase)
		when 2
			@result=Bibl.where(:author=>find_item.downcase)
		when 3
			@result=Bibl.where(:subject=>find_item.downcase)
		when 4
			@result=Bibl.where(:format=>find_item.downcase)
		when 5
			@result=Bibl.where(:language=>find_item.downcase)
		when 6
			@result=Bibl.where(:publisher=>find_item.downcase)
	end
	p @result
	if @result[0]
		@result=ActiveSupport::JSON::encode(@result)
		p @result
		render :text=>@result
	else
		s=t(:"Elements with")+" "
		case find_category
		when 1
			s+=t(:"title")
		when 2
			s+=t(:"author")
		when 3
			s+=t(:"subject")
		when 4
			s+=t(:"format")
		when 5
			s+=t(:"language")
		when 6
			s+=t(:"publisher")
		end
		s+=" '"+find_item.downcase+"', "+t(:"were not found")
		p s
		render :text=>s
	end
  end

  def add
	p params[:form]
	p title=params[:form][:title]
	p author=params[:form][:author]
	p subject=params[:form][:subject]
	p format=params[:form][:format]
	p language=params[:form][:language]
	p publisher=User.find_by_id(current_user).login
	p source=params[:form][:source]
	res=Bibl.where(:title=>title.downcase, :source=>source.downcase, :publisher=>publisher.downcase, :format=>format.downcase)
	if (res.size!=0)
		p res
		s=t(:"This element is already exists in base")
	else
		p res
		if File.exists? Rails.root.to_s+"/public/files/"+source+"."+format
			res=Bibl.create :title=>title.downcase, :author=>author.downcase, :subject=>subject.downcase, :format=>format.downcase, :language=>language.downcase, :publisher=>publisher.downcase, :source=>source.downcase
			if res.save
				s=t(:"Successfully saved")
				puts "SOHRANENIE"
			else
				s=t(:"Occured some problems: One of fields:'title', 'format' or 'name' is not filled")
			end
		else
			s=t(:"FILE WAS NOT FOUND (maybe because of incorrect symbols in the filename)")
		end
	end
	render :text=>s
  end

  def edit
	p params[:form]
	p title=params[:form][:title]
	p author=params[:form][:author]
	p subject=params[:form][:subject]
	p format=params[:form][:format]
	p language=params[:form][:language]
	p publisher=User.find_by_id(current_user).login
	p source=params[:form][:source]
	p id=params[:form][:id].to_i
	if File.exists? Rails.root.to_s+"/public/files/"+source+"."+format
		puts "!!!!"
		res=Bibl.find_by_id(id)
		p res
		res.title=title.downcase
		res.author=author.downcase
		res.subject=subject.downcase
		res.format=format.downcase
		res.language=language.downcase
		res.publisher=publisher.downcase
		res.source=source.downcase
		if res.save
			s=t(:"Successfully updated")
			puts "SOHRANENIE"
		else
			s=t(:"Occured some problems: One of fields:'title', 'format' or 'name' is not filled")
		end
	else
		s=t(:"FILE WAS NOT FOUND (maybe because of incorrect symbols in the filename)")
	end
	render :text=>s
  end

  def delete
	p id=params[:item].to_i
	res=Bibl.where(:id=>id)
	p res
	res[0].destroy()
	puts "UDALENIE"
	res=Bibl.where(:id=>id)
	if !res[0]
		render :text=>t(:"Deleting successfull")
	else
		render :text=>t(:"Occured some problems")
	end
  end
end
