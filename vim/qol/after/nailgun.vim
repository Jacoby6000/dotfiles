let g:nailgun_servers = {
\ "stags": {
\   "bin_name": "stags_ng",
\   "main": "co.pjrt.stags.cli.Main",
\   "port": 2113
\ },
\ "scalafmt": {
\   "bin_name": "scalafmt_ng",
\   "main": "org.scalafmt.cli.Cli",
\   "port": 2114
\ }
\}


for v in values(g:nailgun_servers)
  let v["running"] = 0
endfor

function! NgCommand(appName, args)
  if(!g:nailgun_servers[a:appName]["running"])
    call StartNgServer(a:appName)
  endif

  echo "ng --nailgun-port " . g:nailgun_servers[a:appName]["port"] . " " . g:nailgun_servers[a:appName]["main"] . " " . a:args
  call system("ng --nailgun-port " . g:nailgun_servers[a:appName]["port"] . " " . g:nailgun_servers[a:appName]["main"] . " " . a:args)
endfunction


function! StartNgServer(appName)
  if has_key(g:nailgun_servers, a:appName)
    let app = g:nailgun_servers[a:appName]

    if (has_key(app, "running") && app["running"]) || s:checkServerStatus(a:appName)
    else
      call system("nohup " . app["bin_name"] . " " . app["port"] . "& > $HOME/.config/nvim/ng-" . app["port"] . ".log")
      sleep 100m
      let app["pid"] = s:jps(app["bin_name"])
    endif
  else
    echo "No such nailgun service configured '" . a:appName . "'"
  endif
endfunction

function! StopNgServer(appName, killFlags)
  if (has_key(g:nailgun_servers[a:appName], "running") && g:nailgun_servers[a:appName]["running"]) || s:checkServerStatus(a:appName)
    call system("kill " . a:killFlags . " " . g:nailgun_servers[a:appName]["pid"])
    let g:nailgun_servers[a:appName]["running"] = 0
  endif
endfunction

function! s:jps(processPattern)
  let jps = system("jps | grep ".a:processPattern)
  if jps
    return (0 + split(jps)[0])
  else
    return 0
  endif
endfunction

function! s:checkServerStatus(serverName)
  let v = g:nailgun_servers[a:serverName]
  let pid = s:jps(v["bin_name"])
  if pid
    let v["pid"] = pid
    let v["running"] = 1
    return 1
  else
    let v["running"] = 0
    return 0
  endif
endfunction
