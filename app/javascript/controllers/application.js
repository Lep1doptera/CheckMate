import { Application } from "@hotwired/stimulus"
import AuthController from "controllers/auth_controller"



const application = Application.start()
application.register("auth", AuthController)

// Configure Stimulus development experience
window.Stimulus   = Application


export { application }
