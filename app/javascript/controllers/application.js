import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

//import WeeklyConversationChartController from "./weekly_conversation_chart_controller"
//application.register("weekly-conversation-chart", WeeklyConversationChartController)
