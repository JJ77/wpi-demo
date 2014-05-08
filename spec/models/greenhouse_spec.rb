require 'spec_helper'

describe Greenhouse do

	before do
		@greenhouse = FactoryGirl.create( :greenhouse )
		@other_greenhouse = FactoryGirl.create( :greenhouse )
	end

	subject { @greenhouse }

	it { should respond_to(:location_id) }
	it { should respond_to(:name) }
	it { should respond_to(:description) }


	describe "#beds" do
		before do
			10.times do |this|
				@bed = FactoryGirl.create( :bed, greenhouse: @greenhouse )
			end
			@bed_array = Bed.where(greenhouse_id:@greenhouse.id)
		end

		it "returns an association of all beds in greenhouse" do
			@greenhouse.beds.should eq(@bed_array)
		end
	end

	describe "#history" do
		before do
			@entry = FactoryGirl.create( :entry, status:1, greenhouse_id:@greenhouse.id )
			@entry_array = Entry.where(status:1, greenhouse_id: @greenhouse.id)
		end
		it "returns an association of all history entries in greenhouse" do
			@greenhouse.history.should eq(@entry_array)
		end
	end

	describe "#current" do
		before do
			@entry = FactoryGirl.create( :entry, status:0, greenhouse_id:@greenhouse.id )
			@entry_array = Entry.where(status:0, greenhouse_id: @greenhouse.id)
		end
		it "returns an association of all history entries in greenhouse" do
			@greenhouse.current.should eq(@entry_array)
		end
	end

	describe "#total" do
		before do
			5.times do |this|
				FactoryGirl.create(:entry, greenhouse_id:@greenhouse.id, pots:10, status:0)
				FactoryGirl.create(:entry, greenhouse_id:@greenhouse.id, pots:10, status:1)
			end
			@current_pot_sum = Entry.where(greenhouse_id:@greenhouse.id, status:0).pluck(:pots).inject(:+)
		end

		it "returns a total number of current pots" do
			@greenhouse.total.should eq(@current_pot_sum)
		end
	end

	describe "#capacity" do
		before do
			10.times do |this|
				FactoryGirl.create( :bed, greenhouse_id:@greenhouse.id, capacity:1000)
				FactoryGirl.create( :bed, greenhouse_id:@other_greenhouse.id, capacity:1000)
			end
			@capacity_array = Bed.where(greenhouse_id:@greenhouse.id).pluck(:capacity)
			@capacity = @capacity_array.inject(0) {|result, element| result += element.to_i }
		end
		it "returns total sum of greenhouse's beds' capacities" do
			@greenhouse.capacity.should eq(@capacity)
		end
	end

	describe "validations" do

		describe "name validation" do
			before { @greenhouse = FactoryGirl.build( :greenhouse, name:nil) }
			it "validates name presence and does not save" do
				@greenhouse.save.should eq(false)
			end
		end

		describe "location_id validation" do
			before { @greenhouse = FactoryGirl.build( :greenhouse, location_id:nil) }
			it "validates location presence and does not save" do
				@greenhouse.save.should eq(false)
			end
		end
	end
end
