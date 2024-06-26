function tfp -d "Run terraform/tofu plan, and init if needed"
    set -l cmd terraform
    
    if test $(count argv)
        switch "$argv"
            case "-h"
                echo "tfp - terraform/opentofu init & plan"
                echo ""
                echo " -h          help"
                echo " -f/--force  force init"
                return 1
            case "-f" --force
                echo "🧹 Removing terraform cache"
                path is .terraform && rm -rf .terraform
        end
    end

    # switch to opentofu if tofu exists
    command -vq tofu && set -l cmd tofu

    if not path is *.tf
        echo "No terraform file"
        return 1
    end

    if not path is .terraform
        $cmd init || return 1
    end

    $cmd plan -out=.terraform.plan
end
