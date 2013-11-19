require 'spec_helper'


describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged-in user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end
    
    it_behaves_like "requires authenticated user" do
      let(:action) { get :index }
    end
  end


  describe "POST create" do
    it "redirects to my queue page" do
      #setup, action, verify
      set_current_user
      curb = Fabricate(:video)
      post :create, video_id: curb.id
      expect(response).to redirect_to my_queue_path
    end
    it "creates a queue item" do
      set_current_user
      curb = Fabricate(:video)
      post :create, video_id: curb
      expect(QueueItem.count).to eq(1)
    end
    it "creates the queue item that is associated with the video" do
      set_current_user
      curb = Fabricate(:video)
      post :create, video_id: curb
      expect(QueueItem.first.video).to eq(curb)
    end
    it "creates the queue item that is associated with the logged-in user" do
      alice = Fabricate(:user)
      set_current_user(alice)
      curb = Fabricate(:video)
      post :create, video_id: curb.id
      expect(QueueItem.first.user).to eq(alice)
    end
    it "puts the video as the last one in the queue" do
      alice = Fabricate(:user)
      set_current_user(alice)
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alice)
      south_park = Fabricate(:video)
      post :create, video_id: south_park.id
      south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: alice.id).first
      expect(south_park_queue_item.position).to eq(2)
    end
    it "does not add the video to the queue if the video is already in the queue" do
      alice = Fabricate(:user)
      set_current_user(alice)
      monk = Fabricate(:video)
      Fabricate(:queue_item, video: monk, user: alice)
      post :create, video_id: monk.id
      expect(alice.queue_items.count).to eq(1)
    end 
    it_behaves_like "requires authenticated user" do
      let(:action) { post :create, video_id: 3 }
    end
  end

  describe "DELETE destroy" do
    it "redirects to the my queue page" do
      set_current_user
      queue_item = Fabricate(:queue_item)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to my_queue_path
    end
    it "deletes the queue item" do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item = Fabricate(:queue_item, user: alice)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "normalizes the remaining queue items" do
      alice = Fabricate(:user)
      set_current_user(alice)
      queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
      queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end


    it "does not delete the queue item if the queue item is not in the current user's queue" do
      alice = Fabricate(:user)
      bob = Fabricate(:user)
      set_current_user(alice)
      queue_item = Fabricate(:queue_item, user: bob)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end  

    it_behaves_like "requires authenticated user" do
      let(:action) { delete :destroy, id: 3 }
    end
  end

    describe "POST update_queue" do

      it_behaves_like "requires authenticated user" do
        let(:action) { post :update_queue, queue_items: [{id: 1, position: 3}, {id: 2, position: 2}]
           }
      end

      context "with valid inputs" do
        let(:alice) { Fabricate(:user) }
        let(:queue_item1) { Fabricate(:queue_item, user: alice, position: 1, video: video) }
        let(:queue_item2) { Fabricate(:queue_item, user: alice, position: 2, video: video) }
        let(:video) { Fabricate(:video) }
        before { set_current_user(alice) }

        it "redirects to the my queue page" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(response).to redirect_to my_queue_path
        end
        
        it "reorders the queue items" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(alice.queue_items).to eq([queue_item2, queue_item1])
        end
        it "normalizes the position numbers" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
          expect(alice.queue_items.map(&:position)).to eq([1,2])
          # require 'pry'; binding.pry
          # expect(queue_item1.reload.position).to eq(2)
          # expect(queue_item2.reload.position).to eq(1)
        end 
      end

      context "with invalid inputs" do
        let(:alice) { Fabricate(:user) }
        let(:queue_item1) { Fabricate(:queue_item, user: alice, position: 1, video: video) }
        let(:queue_item2) { Fabricate(:queue_item, user: alice, position: 2, video: video) }
        let(:video) { Fabricate(:video) }
        before do
          session[:user_id] = alice.id
        end

        it "redirects to  the my queue page" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 3.4}]
          expect(response).to redirect_to my_queue_path
        end
        it "sets the flash error message" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 3.4}]
          expect(flash[:error]).to be_present
        end
        it "does not change the queue items" do
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
          expect(queue_item1.reload.position).to eq(1)
        end  
      end

      context "with queue items that do not belong to the current user" do
        it "does not change the queue items" do
          alice = Fabricate(:user)
          bob = Fabricate(:user)
          set_current_user(alice)
          video = Fabricate(:video)
          queue_item1 = Fabricate(:queue_item, user: bob, position: 1, video: video)
          queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: video)
          post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
          expect(queue_item1.reload.position).to eq(1)
        end
      end
    
    end
end








