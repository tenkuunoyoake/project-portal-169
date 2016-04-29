class ProjectsController < ApplicationController
    
    def index
      super
      @projects = Project.all
    end
    
    def edit
      
    end
    
    def create
      @customer = Customer.find_by(email: customer_params[:email], password: customer_params[:password])
      if @customer == nil
        return render body: "Invalid login credentials"
      else
        @project = Project.create(project_params)
        @customer.projects<<@project
        @customer.save!
        redirect_to(project_path(@project))
      end
    end
    
    def show
      @project = Project.find(params[:id])
      @customer = @project.customer
      @student_team = @project.student_team || StudentTeam.new(name: "Unassigned")
      @is_instructor = logged_in_as_instructor
      @is_assigned_msg = "Status: " + if @project.assigned then 'Assigned' else 'Unassigned' end
    end
    
    def assign
      @project = Project.find(params[:id])
      student_team_name = params[:assign][:student_team]
      student_team = StudentTeam.find_by_name(student_team_name)
      if student_team_name and student_team != nil
        student_team.project = @project
        @project.assigned = true
        student_team.save!
      elsif student_team_name == "Unassigned" and @project.student_team != nil
        st = @project.student_team
        st.project= nil
        st.save!
        # @project.student_team = nil
        @project.assigned = false
      end
      @project.save!
      redirect_to(project_path(@project))
    end
    
    private
    
    def project_params
      params.require(:project).permit(:title, :content) 
    end
    
    def customer_params
      params.require(:customer).permit(:name, :email, :password)
    end
    
    #--------------------------------------------------------------------------
    # * Permissions
    #--------------------------------------------------------------------------
    
    def logged_in_as_instructor
      return session[:user_type] == 2
    end
end