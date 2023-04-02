import Notifier from './Notifier.js'

const notifier = new Notifier()

document.body.addEventListener('click', e => {
	const { target } = e

	if (target.tagName.toLowerCase() !== 'button') return
	
  const cls = target.textContent.match(/\[(\w+)\]/)[1]

	notifier.add({
		title: 'This is the title',
		body: 'This is some random text that will constitute the body of the message',
		cls
	})
})

export default notifier
