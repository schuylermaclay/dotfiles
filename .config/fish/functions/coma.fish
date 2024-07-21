function coma --description 'Function to check if ollama is running and start it if not'
    set ollama_running (launchctl list | grep -c homebrew.mxcl.ollama)
    if test $ollama_running -eq 0
        brew services start ollama
    end

    # Run 'ollama run codellama' with the provided argument
    ollama run codellama $argv
end
