import utils from './utils.js'
import Notification from './Notification.js'

class Notifier {  
  constructor() {
    if (!Notifier.instance) {
      Notifier.instance = this;
      this.notifications = [];
        
      // Create the notifier container if it doesn't exist
      if (!this.container) {
        this.createContainer()
        this.createTemplate()
      }
    }

    return Notifier.instance;
  }

  createContainer() {
    this.container = utils.createElement({ id: 'notifier-container' })
    this.container.addEventListener('transitionend', e => {
      const { target, propertyName } = e

      if (!target.classList.contains('begone') || propertyName !== 'transform') return
    
      this.remove(target.dataset.notificationId)
    })
    document.body.prepend(this.container)
  }

  createTemplate() {
    const content = `<div class="card hidden">
      <div class="background"></div>
      <div class="foreground">
        <div class="icon"><img /></div>
        <div class="info">
          <h2>Example title</h2>
          <p>Example body
        </div>
        <div class="countdown">
          <svg viewBox='0 0 10 10'>
            <circle cx="11" cy="5" r="4" stroke="#d5b914cf" data-fallback="edge"
            stroke-width="1px"
            transform="rotate(-90, 8, 8)"
            stroke-dasharray="0, 100">
        
              <animate attributeName="stroke-dasharray"
                dur="24s" to="100,100"
                fill="freeze" />
            </circle>
          </svg>
      
          <span>10</span>
        </div>
      </div>
    </div>`

    this.template = utils.createElement({
      tagName: 'template',
      id: 'notifier-template'
    })
    this.template.innerHTML = content
    this.container.appendChild(this.template)
  }

  add(options = {}) {
    this.notifications.push(new Notification({
      ...options,
      container: this.container,
      templateContent: this.template.content
    }))
  }

  remove(id) {
    this.notifications.splice(this.notifications.findIndex(n => n.id === id), 1)[0].destroy()
  }
}

export default Notifier
