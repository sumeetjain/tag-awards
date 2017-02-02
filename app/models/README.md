# TODO

Need to add one or more new models that belong to (or maybe HABTM) plays. Every actor in a play, the play's director(s), the play's crew positions, etc.

Then in Admin, TAG needs to be able to indicate for each play all of the people affiliated with it and for what award.

So there is probably a single resource at the intersection, maybe called `PotentialNominee`. It belongs to a `Person` (NOTE1), `Play`, and `Award`.

NOTE1: If there are multiple people who comprise a single "nominee"--like two co-directors--then both names should be a single `Person` record.