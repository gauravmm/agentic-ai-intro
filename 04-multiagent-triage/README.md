# Multiagent

Things for students to do:

1. Notice that the `intake-bot` needs information from the `triage-bot` conversation that the `triage-bot` doesn't need. Get the `triage bot` to gather the relavant information.
2. Notice that the
3. Ask them to break the bot.
  a. convince the bot to schdule an appointment unnecessarily (breaking a "liveness" guarantee), or
  b. not escalate an emergency (breaking a "safety" guarantee.)
  c. How can you mitigate that?
4. Does it try to use external tools?
  a. is there a risk of that
5. Does it communicate effectively?
  a. It sometimes books an appointment without telling the user when it is.
6. Did the triage tool ever fail validation?
  a. "Backpressure" or a "classical validator" can help catch large classes of bugs early. Designing this well into
7. If we know we want to escalate, should we first gather details?
