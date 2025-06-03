## Dev Testing
![img.png](../images/local-testing.png)

## Improved Fault Tolerance and Scalability
![img_1.png](../images/fault-tolerance.png)

## Special Release Workflow
![img.png](../images/special-release.png)

## Expanded Requirements
- **Dev Testing** - we should have the option to boot up a test environment with 
less expensive and fault tolerance resources based Github PR Open events for feature branches so that devs
can test their changes before merging to main. On PR closed and merged events, we should also tear down the test infra.
- **Fault Tolerance and Scalability** - if our single instance of the bastion host or service goes down, were screwed.
We show increase availability by deploying to another Availability Zone (AZ) in the same region or another region.
We should also apply autoscaling (keeping in mind our subnet CIDR range) to prevent downtime from a potentially
overloaded instance receiving too much traffic. Who takes on this increased infra costs - assuming the customer?
- **Special Release Workflow** - on release label events, we should have a special workflow that runs higher coverage
validation, deploys the infra to production, and once successfully deployed, we should persists the change deployed so
we can audit and have for reference across customers.

## Final Thoughts
- If we want to be able to make terraform changes after the Github Actions completes,
how do we do that? The state file and plan file wont be persisted. Do we store the relevant files
in some type of storage like S3?