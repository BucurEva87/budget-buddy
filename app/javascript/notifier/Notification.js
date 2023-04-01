import utils from './utils.js'

class Notification {
  constructor(options) {
    Object.entries(Object.assign({
      icon: 'https://media.istockphoto.com/id/460140985/photo/dynamite.jpg?s=612x612&w=0&k=20&c=_Cd0pJYFACPZl7_xRhfvYiGGusLUxu4Nsr7TDnFYjxQ=',
      cls: 'info',
      callback: () => {
        this.node.classList.add('begone')
        console.log('Notificarea a disparut')
      },
      remaining: 30000,
      tickTime: 1000
    }, options)).forEach(([key, value]) => this[key] = value)

    this.start = null
    this.timerId = true

    this.create()
    this.resume()
  }

  create() {
    const clone = document.importNode(this.templateContent, true)

    this.id = crypto.randomUUID()
    this.container.appendChild(clone)
    this.node = utils.qsa('.card', this.container).at(-1)
    this.node.classList.add(this.cls)
    this.node.dataset.noticeId = this.id
    utils.qs('img', this.node).src = this.icon
	  utils.qs('h2', this.node).textContent = this.title
	  utils.qs('p', this.node).textContent = this.body
    utils.qs('.countdown span', this.node).textContent = Math.floor(this.remaining / this.tickTime)

    setTimeout(() => this.node.classList.remove('hidden'), 0)
  }

  pause() {
    clearInterval(this.timerId)
    this.timerId = null
  }

  resume() {
    if (this.timerId) return

    this.timerId = setInterval(() => this.tick(), this.tickTime)
  }

  tick() {
    this.remaining -= this.tickTime
    const countdown = utils.qs('.countdown span', this.node)
    const oldTime = +countdown.textContent
    const newTime = oldTime - 1

    countdown.textContent = newTime

    if (this.remaining <= 0) this.callback()
  }

  destroy() {
    clearInterval(this.timerId)
    this.timerId = null
    this.node.remove()
  }
}

export default Notification
