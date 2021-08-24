def projects = [
  "elastic-applications",
  "elastic-configurations"
]

for (i=0; i<projects.size(); i++) {
  pipelineJob(projects[i]) {
    definition {
      cpsScm {
        scm {
          git {
            branches("master", "test/*")
            remote {
              name("localremote_" + projects[i])
              url("file:///tmp/projects/" + projects[i])
            }
          }
        }
        scriptPath("Jenkinsfile")
      }
    }
    
    triggers {
      genericTrigger {
        genericVariables {
          genericVariable {
            key("BRANCH")
            value("\$.ref")
          }
          genericVariable {
            key("REPO")
            value("\$.repository.name")
          }
        }

        causeString("Webhook Triggered")
        tokenCredentialId("git-local-webhook-token")
        silentResponse(false)

        // TODO Improve this
        // regexpFilterText("\$BRANCH \$REPO")
        // regexpFilterExpression('^(refs/heads/master\\s' + projects[i] + ')$')

        // TODO 
        regexpFilterText("")
        regexpFilterExpression('')
      }
    }
  }
}
