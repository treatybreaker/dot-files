var un=Object.create;var B=Object.defineProperty;var ln=Object.getOwnPropertyDescriptor;var dn=Object.getOwnPropertyNames;var fn=Object.getPrototypeOf,pn=Object.prototype.hasOwnProperty;var Ee=e=>B(e,"__esModule",{value:!0});var p=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports),mn=(e,t)=>{for(var n in t)B(e,n,{get:t[n],enumerable:!0})},Pe=(e,t,n,r)=>{if(t&&typeof t=="object"||typeof t=="function")for(let o of dn(t))!pn.call(e,o)&&(n||o!=="default")&&B(e,o,{get:()=>t[o],enumerable:!(r=ln(t,o))||r.enumerable});return e},w=(e,t)=>Pe(Ee(B(e!=null?un(fn(e)):{},"default",!t&&e&&e.__esModule?{get:()=>e.default,enumerable:!0}:{value:e,enumerable:!0})),e),hn=(e=>(t,n)=>e&&e.get(t)||(n=Pe(Ee({}),t,1),e&&e.set(t,n),n))(typeof WeakMap!="undefined"?new WeakMap:0);var Ge=p((kr,Ae)=>{Ae.exports=Ce;Ce.sync=gn;var Ie=require("fs");function Sn(e,t){var n=t.pathExt!==void 0?t.pathExt:process.env.PATHEXT;if(!n||(n=n.split(";"),n.indexOf("")!==-1))return!0;for(var r=0;r<n.length;r++){var o=n[r].toLowerCase();if(o&&e.substr(-o.length).toLowerCase()===o)return!0}return!1}function Te(e,t,n){return!e.isSymbolicLink()&&!e.isFile()?!1:Sn(t,n)}function Ce(e,t,n){Ie.stat(e,function(r,o){n(r,r?!1:Te(o,e,t))})}function gn(e,t){return Te(Ie.statSync(e),e,t)}});var ke=p((Fr,Ne)=>{Ne.exports=$e;$e.sync=yn;var Re=require("fs");function $e(e,t,n){Re.stat(e,function(r,o){n(r,r?!1:Oe(o,t))})}function yn(e,t){return Oe(Re.statSync(e),t)}function Oe(e,t){return e.isFile()&&xn(e,t)}function xn(e,t){var n=e.mode,r=e.uid,o=e.gid,i=t.uid!==void 0?t.uid:process.getuid&&process.getuid(),s=t.gid!==void 0?t.gid:process.getgid&&process.getgid(),c=parseInt("100",8),l=parseInt("010",8),d=parseInt("001",8),f=c|l,S=n&d||n&l&&o===s||n&c&&r===i||n&f&&i===0;return S}});var Le=p((jr,Fe)=>{var Lr=require("fs"),M;process.platform==="win32"||global.TESTING_WINDOWS?M=Ge():M=ke();Fe.exports=z;z.sync=wn;function z(e,t,n){if(typeof t=="function"&&(n=t,t={}),!n){if(typeof Promise!="function")throw new TypeError("callback not provided");return new Promise(function(r,o){z(e,t||{},function(i,s){i?o(i):r(s)})})}M(e,t||{},function(r,o){r&&(r.code==="EACCES"||t&&t.ignoreErrors)&&(r=null,o=!1),n(r,o)})}function wn(e,t){try{return M.sync(e,t||{})}catch(n){if(t&&t.ignoreErrors||n.code==="EACCES")return!1;throw n}}});var De=p((Br,Ue)=>{var P=process.platform==="win32"||process.env.OSTYPE==="cygwin"||process.env.OSTYPE==="msys",je=require("path"),bn=P?";":":",Be=Le(),Me=e=>Object.assign(new Error(`not found: ${e}`),{code:"ENOENT"}),_e=(e,t)=>{let n=t.colon||bn,r=e.match(/\//)||P&&e.match(/\\/)?[""]:[...P?[process.cwd()]:[],...(t.path||process.env.PATH||"").split(n)],o=P?t.pathExt||process.env.PATHEXT||".EXE;.CMD;.BAT;.COM":"",i=P?o.split(n):[""];return P&&e.indexOf(".")!==-1&&i[0]!==""&&i.unshift(""),{pathEnv:r,pathExt:i,pathExtExe:o}},qe=(e,t,n)=>{typeof t=="function"&&(n=t,t={}),t||(t={});let{pathEnv:r,pathExt:o,pathExtExe:i}=_e(e,t),s=[],c=d=>new Promise((f,S)=>{if(d===r.length)return t.all&&s.length?f(s):S(Me(e));let h=r[d],g=/^".*"$/.test(h)?h.slice(1,-1):h,y=je.join(g,e),x=!g&&/^\.[\\\/]/.test(e)?e.slice(0,2)+y:y;f(l(x,d,0))}),l=(d,f,S)=>new Promise((h,g)=>{if(S===o.length)return h(c(f+1));let y=o[S];Be(d+y,{pathExt:i},(x,E)=>{if(!x&&E)if(t.all)s.push(d+y);else return h(d+y);return h(l(d,f,S+1))})});return n?c(0).then(d=>n(null,d),n):c(0)},vn=(e,t)=>{t=t||{};let{pathEnv:n,pathExt:r,pathExtExe:o}=_e(e,t),i=[];for(let s=0;s<n.length;s++){let c=n[s],l=/^".*"$/.test(c)?c.slice(1,-1):c,d=je.join(l,e),f=!l&&/^\.[\\\/]/.test(e)?e.slice(0,2)+d:d;for(let S=0;S<r.length;S++){let h=f+r[S];try{if(Be.sync(h,{pathExt:o}))if(t.all)i.push(h);else return h}catch{}}}if(t.all&&i.length)return i;if(t.nothrow)return null;throw Me(e)};Ue.exports=qe;qe.sync=vn});var Xe=p((Mr,V)=>{"use strict";var He=(e={})=>{let t=e.env||process.env;return(e.platform||process.platform)!=="win32"?"PATH":Object.keys(t).reverse().find(r=>r.toUpperCase()==="PATH")||"Path"};V.exports=He;V.exports.default=He});var Ve=p((_r,ze)=>{"use strict";var Ke=require("path"),En=De(),Pn=Xe();function We(e,t){let n=e.options.env||process.env,r=process.cwd(),o=e.options.cwd!=null,i=o&&process.chdir!==void 0&&!process.chdir.disabled;if(i)try{process.chdir(e.options.cwd)}catch{}let s;try{s=En.sync(e.command,{path:n[Pn({env:n})],pathExt:t?Ke.delimiter:void 0})}catch{}finally{i&&process.chdir(r)}return s&&(s=Ke.resolve(o?e.options.cwd:"",s)),s}function In(e){return We(e)||We(e,!0)}ze.exports=In});var Ye=p((qr,Q)=>{"use strict";var Y=/([()\][%!^"`<>&|;, *?])/g;function Tn(e){return e=e.replace(Y,"^$1"),e}function Cn(e,t){return e=`${e}`,e=e.replace(/(\\*)"/g,'$1$1\\"'),e=e.replace(/(\\*)$/,"$1$1"),e=`"${e}"`,e=e.replace(Y,"^$1"),t&&(e=e.replace(Y,"^$1")),e}Q.exports.command=Tn;Q.exports.argument=Cn});var Ze=p((Ur,Qe)=>{"use strict";Qe.exports=/^#!(.*)/});var et=p((Dr,Je)=>{"use strict";var An=Ze();Je.exports=(e="")=>{let t=e.match(An);if(!t)return null;let[n,r]=t[0].replace(/#! ?/,"").split(" "),o=n.split("/").pop();return o==="env"?r:r?`${o} ${r}`:o}});var nt=p((Hr,tt)=>{"use strict";var Z=require("fs"),Gn=et();function Rn(e){let t=150,n=Buffer.alloc(t),r;try{r=Z.openSync(e,"r"),Z.readSync(r,n,0,t,0),Z.closeSync(r)}catch{}return Gn(n.toString())}tt.exports=Rn});var st=p((Xr,it)=>{"use strict";var $n=require("path"),rt=Ve(),ot=Ye(),On=nt(),Nn=process.platform==="win32",kn=/\.(?:com|exe)$/i,Fn=/node_modules[\\/].bin[\\/][^\\/]+\.cmd$/i;function Ln(e){e.file=rt(e);let t=e.file&&On(e.file);return t?(e.args.unshift(e.file),e.command=t,rt(e)):e.file}function jn(e){if(!Nn)return e;let t=Ln(e),n=!kn.test(t);if(e.options.forceShell||n){let r=Fn.test(t);e.command=$n.normalize(e.command),e.command=ot.command(e.command),e.args=e.args.map(i=>ot.argument(i,r));let o=[e.command].concat(e.args).join(" ");e.args=["/d","/s","/c",`"${o}"`],e.command=process.env.comspec||"cmd.exe",e.options.windowsVerbatimArguments=!0}return e}function Bn(e,t,n){t&&!Array.isArray(t)&&(n=t,t=null),t=t?t.slice(0):[],n=Object.assign({},n);let r={command:e,args:t,options:n,file:void 0,original:{command:e,args:t}};return n.shell?r:jn(r)}it.exports=Bn});var ut=p((Kr,ct)=>{"use strict";var J=process.platform==="win32";function ee(e,t){return Object.assign(new Error(`${t} ${e.command} ENOENT`),{code:"ENOENT",errno:"ENOENT",syscall:`${t} ${e.command}`,path:e.command,spawnargs:e.args})}function Mn(e,t){if(!J)return;let n=e.emit;e.emit=function(r,o){if(r==="exit"){let i=at(o,t,"spawn");if(i)return n.call(e,"error",i)}return n.apply(e,arguments)}}function at(e,t){return J&&e===1&&!t.file?ee(t.original,"spawn"):null}function _n(e,t){return J&&e===1&&!t.file?ee(t.original,"spawnSync"):null}ct.exports={hookChildProcess:Mn,verifyENOENT:at,verifyENOENTSync:_n,notFoundError:ee}});var ft=p((Wr,I)=>{"use strict";var lt=require("child_process"),te=st(),ne=ut();function dt(e,t,n){let r=te(e,t,n),o=lt.spawn(r.command,r.args,r.options);return ne.hookChildProcess(o,r),o}function qn(e,t,n){let r=te(e,t,n),o=lt.spawnSync(r.command,r.args,r.options);return o.error=o.error||ne.verifyENOENTSync(o.status,r),o}I.exports=dt;I.exports.spawn=dt;I.exports.sync=qn;I.exports._parse=te;I.exports._enoent=ne});var Et=p((mo,D)=>{D.exports=["SIGABRT","SIGALRM","SIGHUP","SIGINT","SIGTERM"];process.platform!=="win32"&&D.exports.push("SIGVTALRM","SIGXCPU","SIGXFSZ","SIGUSR2","SIGTRAP","SIGSYS","SIGQUIT","SIGIOT");process.platform==="linux"&&D.exports.push("SIGIO","SIGPOLL","SIGPWR","SIGSTKFLT","SIGUNUSED")});var At=p((ho,G)=>{var u=global.process;typeof u!="object"||!u?G.exports=function(){}:(Pt=require("assert"),C=Et(),It=/^win/i.test(u.platform),O=require("events"),typeof O!="function"&&(O=O.EventEmitter),u.__signal_exit_emitter__?m=u.__signal_exit_emitter__:(m=u.__signal_exit_emitter__=new O,m.count=0,m.emitted={}),m.infinite||(m.setMaxListeners(1/0),m.infinite=!0),G.exports=function(e,t){if(global.process===u){Pt.equal(typeof e,"function","a callback must be provided for exit handler"),A===!1&&ce();var n="exit";t&&t.alwaysLast&&(n="afterexit");var r=function(){m.removeListener(n,e),m.listeners("exit").length===0&&m.listeners("afterexit").length===0&&H()};return m.on(n,e),r}},H=function(){!A||global.process!==u||(A=!1,C.forEach(function(t){try{u.removeListener(t,X[t])}catch{}}),u.emit=K,u.reallyExit=ue,m.count-=1)},G.exports.unload=H,b=function(t,n,r){m.emitted[t]||(m.emitted[t]=!0,m.emit(t,n,r))},X={},C.forEach(function(e){X[e]=function(){if(u===global.process){var n=u.listeners(e);n.length===m.count&&(H(),b("exit",null,e),b("afterexit",null,e),It&&e==="SIGHUP"&&(e="SIGINT"),u.kill(u.pid,e))}}}),G.exports.signals=function(){return C},A=!1,ce=function(){A||u!==global.process||(A=!0,m.count+=1,C=C.filter(function(t){try{return u.on(t,X[t]),!0}catch{return!1}}),u.emit=Ct,u.reallyExit=Tt)},G.exports.load=ce,ue=u.reallyExit,Tt=function(t){u===global.process&&(u.exitCode=t||0,b("exit",u.exitCode,null),b("afterexit",u.exitCode,null),ue.call(u,u.exitCode))},K=u.emit,Ct=function(t,n){if(t==="exit"&&u===global.process){n!==void 0&&(u.exitCode=n);var r=K.apply(this,arguments);return b("exit",u.exitCode,null),b("afterexit",u.exitCode,null),r}else return K.apply(this,arguments)});var Pt,C,It,O,m,H,b,X,A,ce,ue,Tt,K,Ct});var Bt=p((yo,jt)=>{"use strict";var{PassThrough:dr}=require("stream");jt.exports=e=>{e={...e};let{array:t}=e,{encoding:n}=e,r=n==="buffer",o=!1;t?o=!(n||r):n=n||"utf8",r&&(n=null);let i=new dr({objectMode:o});n&&i.setEncoding(n);let s=0,c=[];return i.on("data",l=>{c.push(l),o?s=c.length:s+=l.length}),i.getBufferedValue=()=>t?c:r?Buffer.concat(c,s):c.join(""),i.getBufferedLength=()=>s,i}});var Mt=p((xo,N)=>{"use strict";var{constants:fr}=require("buffer"),pr=require("stream"),{promisify:mr}=require("util"),hr=Bt(),Sr=mr(pr.pipeline),le=class extends Error{constructor(){super("maxBuffer exceeded");this.name="MaxBufferError"}};async function de(e,t){if(!e)throw new Error("Expected a stream");t={maxBuffer:1/0,...t};let{maxBuffer:n}=t,r=hr(t);return await new Promise((o,i)=>{let s=c=>{c&&r.getBufferedLength()<=fr.MAX_LENGTH&&(c.bufferedData=r.getBufferedValue()),i(c)};(async()=>{try{await Sr(e,r),o()}catch(c){s(c)}})(),r.on("data",()=>{r.getBufferedLength()>n&&s(new le)})}),r.getBufferedValue()}N.exports=de;N.exports.buffer=(e,t)=>de(e,{...t,encoding:"buffer"});N.exports.array=(e,t)=>de(e,{...t,array:!0});N.exports.MaxBufferError=le});var qt=p((wo,_t)=>{"use strict";var{PassThrough:gr}=require("stream");_t.exports=function(){var e=[],t=new gr({objectMode:!0});return t.setMaxListeners(0),t.add=n,t.isEmpty=r,t.on("unpipe",o),Array.prototype.slice.call(arguments).forEach(n),t;function n(i){return Array.isArray(i)?(i.forEach(n),this):(e.push(i),i.once("end",o.bind(null,i)),i.once("error",t.emit.bind(t,"error")),i.pipe(t,{end:!1}),this)}function r(){return e.length==0}function o(i){e=e.filter(function(s){return s!==i}),!e.length&&t.readable&&t.end()}}});var Or={};mn(Or,{default:()=>an});var W=require("react");var a=require("@raycast/api");var Qt=require("buffer"),Zt=w(require("path"),1),Se=w(require("child_process"),1),k=w(require("process"),1),Jt=w(ft(),1);function re(e){let t=typeof e=="string"?`
`:`
`.charCodeAt(),n=typeof e=="string"?"\r":"\r".charCodeAt();return e[e.length-1]===t&&(e=e.slice(0,-1)),e[e.length-1]===n&&(e=e.slice(0,-1)),e}var $=w(require("process"),1),T=w(require("path"),1);function _(e={}){let{env:t=process.env,platform:n=process.platform}=e;return n!=="win32"?"PATH":Object.keys(t).reverse().find(r=>r.toUpperCase()==="PATH")||"Path"}function Un(e={}){let{cwd:t=$.default.cwd(),path:n=$.default.env[_()],execPath:r=$.default.execPath}=e,o,i=T.default.resolve(t),s=[];for(;o!==i;)s.push(T.default.join(i,"node_modules/.bin")),o=i,i=T.default.resolve(i,"..");return s.push(T.default.resolve(t,r,"..")),[...s,n].join(T.default.delimiter)}function pt({env:e=$.default.env,...t}={}){e={...e};let n=_({env:e});return t.path=e[n],e[n]=Un(t),e}var Dn=(e,t,n,r)=>{if(n==="length"||n==="prototype"||n==="arguments"||n==="caller")return;let o=Object.getOwnPropertyDescriptor(e,n),i=Object.getOwnPropertyDescriptor(t,n);!Hn(o,i)&&r||Object.defineProperty(e,n,i)},Hn=function(e,t){return e===void 0||e.configurable||e.writable===t.writable&&e.enumerable===t.enumerable&&e.configurable===t.configurable&&(e.writable||e.value===t.value)},Xn=(e,t)=>{let n=Object.getPrototypeOf(t);n!==Object.getPrototypeOf(e)&&Object.setPrototypeOf(e,n)},Kn=(e,t)=>`/* Wrapped ${e}*/
${t}`,Wn=Object.getOwnPropertyDescriptor(Function.prototype,"toString"),zn=Object.getOwnPropertyDescriptor(Function.prototype.toString,"name"),Vn=(e,t,n)=>{let r=n===""?"":`with ${n.trim()}() `,o=Kn.bind(null,r,t.toString());Object.defineProperty(o,"name",zn),Object.defineProperty(e,"toString",{...Wn,value:o})};function oe(e,t,{ignoreNonConfigurable:n=!1}={}){let{name:r}=e;for(let o of Reflect.ownKeys(t))Dn(e,t,o,n);return Xn(e,t),Vn(e,t,r),e}var q=new WeakMap,mt=(e,t={})=>{if(typeof e!="function")throw new TypeError("Expected a function");let n,r=0,o=e.displayName||e.name||"<anonymous>",i=function(...s){if(q.set(i,++r),r===1)n=e.apply(this,s),e=null;else if(t.throw===!0)throw new Error(`Function \`${o}\` can only be called once`);return n};return oe(i,e),q.set(i,r),i};mt.callCount=e=>{if(!q.has(e))throw new Error(`The given function \`${e.name}\` is not wrapped by the \`onetime\` package`);return q.get(e)};var ht=mt;var wt=require("os");var St=function(){let e=ie-gt+1;return Array.from({length:e},Yn)},Yn=function(e,t){return{name:`SIGRT${t+1}`,number:gt+t,action:"terminate",description:"Application-specific signal (realtime)",standard:"posix"}},gt=34,ie=64;var xt=require("os");var yt=[{name:"SIGHUP",number:1,action:"terminate",description:"Terminal closed",standard:"posix"},{name:"SIGINT",number:2,action:"terminate",description:"User interruption with CTRL-C",standard:"ansi"},{name:"SIGQUIT",number:3,action:"core",description:"User interruption with CTRL-\\",standard:"posix"},{name:"SIGILL",number:4,action:"core",description:"Invalid machine instruction",standard:"ansi"},{name:"SIGTRAP",number:5,action:"core",description:"Debugger breakpoint",standard:"posix"},{name:"SIGABRT",number:6,action:"core",description:"Aborted",standard:"ansi"},{name:"SIGIOT",number:6,action:"core",description:"Aborted",standard:"bsd"},{name:"SIGBUS",number:7,action:"core",description:"Bus error due to misaligned, non-existing address or paging error",standard:"bsd"},{name:"SIGEMT",number:7,action:"terminate",description:"Command should be emulated but is not implemented",standard:"other"},{name:"SIGFPE",number:8,action:"core",description:"Floating point arithmetic error",standard:"ansi"},{name:"SIGKILL",number:9,action:"terminate",description:"Forced termination",standard:"posix",forced:!0},{name:"SIGUSR1",number:10,action:"terminate",description:"Application-specific signal",standard:"posix"},{name:"SIGSEGV",number:11,action:"core",description:"Segmentation fault",standard:"ansi"},{name:"SIGUSR2",number:12,action:"terminate",description:"Application-specific signal",standard:"posix"},{name:"SIGPIPE",number:13,action:"terminate",description:"Broken pipe or socket",standard:"posix"},{name:"SIGALRM",number:14,action:"terminate",description:"Timeout or timer",standard:"posix"},{name:"SIGTERM",number:15,action:"terminate",description:"Termination",standard:"ansi"},{name:"SIGSTKFLT",number:16,action:"terminate",description:"Stack is empty or overflowed",standard:"other"},{name:"SIGCHLD",number:17,action:"ignore",description:"Child process terminated, paused or unpaused",standard:"posix"},{name:"SIGCLD",number:17,action:"ignore",description:"Child process terminated, paused or unpaused",standard:"other"},{name:"SIGCONT",number:18,action:"unpause",description:"Unpaused",standard:"posix",forced:!0},{name:"SIGSTOP",number:19,action:"pause",description:"Paused",standard:"posix",forced:!0},{name:"SIGTSTP",number:20,action:"pause",description:'Paused using CTRL-Z or "suspend"',standard:"posix"},{name:"SIGTTIN",number:21,action:"pause",description:"Background process cannot read terminal input",standard:"posix"},{name:"SIGBREAK",number:21,action:"terminate",description:"User interruption with CTRL-BREAK",standard:"other"},{name:"SIGTTOU",number:22,action:"pause",description:"Background process cannot write to terminal output",standard:"posix"},{name:"SIGURG",number:23,action:"ignore",description:"Socket received out-of-band data",standard:"bsd"},{name:"SIGXCPU",number:24,action:"core",description:"Process timed out",standard:"bsd"},{name:"SIGXFSZ",number:25,action:"core",description:"File too big",standard:"bsd"},{name:"SIGVTALRM",number:26,action:"terminate",description:"Timeout or timer",standard:"bsd"},{name:"SIGPROF",number:27,action:"terminate",description:"Timeout or timer",standard:"bsd"},{name:"SIGWINCH",number:28,action:"ignore",description:"Terminal window size changed",standard:"bsd"},{name:"SIGIO",number:29,action:"terminate",description:"I/O is available",standard:"other"},{name:"SIGPOLL",number:29,action:"terminate",description:"Watched event",standard:"other"},{name:"SIGINFO",number:29,action:"ignore",description:"Request for process information",standard:"other"},{name:"SIGPWR",number:30,action:"terminate",description:"Device running out of power",standard:"systemv"},{name:"SIGSYS",number:31,action:"core",description:"Invalid system call",standard:"other"},{name:"SIGUNUSED",number:31,action:"terminate",description:"Invalid system call",standard:"other"}];var se=function(){let e=St();return[...yt,...e].map(Qn)},Qn=function({name:e,number:t,description:n,action:r,forced:o=!1,standard:i}){let{signals:{[e]:s}}=xt.constants,c=s!==void 0;return{name:e,number:c?s:t,description:n,supported:c,action:r,forced:o,standard:i}};var Zn=function(){return se().reduce(Jn,{})},Jn=function(e,{name:t,number:n,description:r,supported:o,action:i,forced:s,standard:c}){return{...e,[t]:{name:t,number:n,description:r,supported:o,action:i,forced:s,standard:c}}},bt=Zn(),er=function(){let e=se(),t=ie+1,n=Array.from({length:t},(r,o)=>tr(o,e));return Object.assign({},...n)},tr=function(e,t){let n=nr(e,t);if(n===void 0)return{};let{name:r,description:o,supported:i,action:s,forced:c,standard:l}=n;return{[e]:{name:r,number:e,description:o,supported:i,action:s,forced:c,standard:l}}},nr=function(e,t){let n=t.find(({name:r})=>wt.constants.signals[r]===e);return n!==void 0?n:t.find(r=>r.number===e)},co=er();var rr=({timedOut:e,timeout:t,errorCode:n,signal:r,signalDescription:o,exitCode:i,isCanceled:s})=>e?`timed out after ${t} milliseconds`:s?"was canceled":n!==void 0?`failed with ${n}`:r!==void 0?`was killed with ${r} (${o})`:i!==void 0?`failed with exit code ${i}`:"failed",ae=({stdout:e,stderr:t,all:n,error:r,signal:o,exitCode:i,command:s,escapedCommand:c,timedOut:l,isCanceled:d,killed:f,parsed:{options:{timeout:S}}})=>{i=i===null?void 0:i,o=o===null?void 0:o;let h=o===void 0?void 0:bt[o].description,g=r&&r.code,x=`Command ${rr({timedOut:l,timeout:S,errorCode:g,signal:o,signalDescription:h,exitCode:i,isCanceled:d})}: ${s}`,E=Object.prototype.toString.call(r)==="[object Error]",L=E?`${x}
${r.message}`:x,j=[L,t,e].filter(Boolean).join(`
`);return E?(r.originalMessage=r.message,r.message=j):r=new Error(j),r.shortMessage=L,r.command=s,r.escapedCommand=c,r.exitCode=i,r.signal=o,r.signalDescription=h,r.stdout=e,r.stderr=t,n!==void 0&&(r.all=n),"bufferedData"in r&&delete r.bufferedData,r.failed=!0,r.timedOut=Boolean(l),r.isCanceled=d,r.killed=f&&!l,r};var U=["stdin","stdout","stderr"],or=e=>U.some(t=>e[t]!==void 0),vt=e=>{if(!e)return;let{stdio:t}=e;if(t===void 0)return U.map(r=>e[r]);if(or(e))throw new Error(`It's not possible to provide \`stdio\` in combination with one of ${U.map(r=>`\`${r}\``).join(", ")}`);if(typeof t=="string")return t;if(!Array.isArray(t))throw new TypeError(`Expected \`stdio\` to be of type \`string\` or \`Array\`, got \`${typeof t}\``);let n=Math.max(t.length,U.length);return Array.from({length:n},(r,o)=>t[o])};var Gt=w(require("os"),1),Rt=w(At(),1),ir=1e3*5,$t=(e,t="SIGTERM",n={})=>{let r=e(t);return sr(e,t,n,r),r},sr=(e,t,n,r)=>{if(!ar(t,n,r))return;let o=ur(n),i=setTimeout(()=>{e("SIGKILL")},o);i.unref&&i.unref()},ar=(e,{forceKillAfterTimeout:t},n)=>cr(e)&&t!==!1&&n,cr=e=>e===Gt.default.constants.signals.SIGTERM||typeof e=="string"&&e.toUpperCase()==="SIGTERM",ur=({forceKillAfterTimeout:e=!0})=>{if(e===!0)return ir;if(!Number.isFinite(e)||e<0)throw new TypeError(`Expected the \`forceKillAfterTimeout\` option to be a non-negative integer, got \`${e}\` (${typeof e})`);return e},Ot=(e,t)=>{e.kill()&&(t.isCanceled=!0)},lr=(e,t,n)=>{e.kill(t),n(Object.assign(new Error("Timed out"),{timedOut:!0,signal:t}))},Nt=(e,{timeout:t,killSignal:n="SIGTERM"},r)=>{if(t===0||t===void 0)return r;let o,i=new Promise((c,l)=>{o=setTimeout(()=>{lr(e,n,l)},t)}),s=r.finally(()=>{clearTimeout(o)});return Promise.race([i,s])},kt=({timeout:e})=>{if(e!==void 0&&(!Number.isFinite(e)||e<0))throw new TypeError(`Expected the \`timeout\` option to be a non-negative integer, got \`${e}\` (${typeof e})`)},Ft=async(e,{cleanup:t,detached:n},r)=>{if(!t||n)return r;let o=(0,Rt.default)(()=>{e.kill()});return r.finally(()=>{o()})};function Lt(e){return e!==null&&typeof e=="object"&&typeof e.pipe=="function"}var fe=w(Mt(),1),Ut=w(qt(),1),Dt=(e,t)=>{t===void 0||e.stdin===void 0||(Lt(t)?t.pipe(e.stdin):e.stdin.end(t))},Ht=(e,{all:t})=>{if(!t||!e.stdout&&!e.stderr)return;let n=(0,Ut.default)();return e.stdout&&n.add(e.stdout),e.stderr&&n.add(e.stderr),n},pe=async(e,t)=>{if(!!e){e.destroy();try{return await t}catch(n){return n.bufferedData}}},me=(e,{encoding:t,buffer:n,maxBuffer:r})=>{if(!(!e||!n))return t?(0,fe.default)(e,{encoding:t,maxBuffer:r}):fe.default.buffer(e,{maxBuffer:r})},Xt=async({stdout:e,stderr:t,all:n},{encoding:r,buffer:o,maxBuffer:i},s)=>{let c=me(e,{encoding:r,buffer:o,maxBuffer:i}),l=me(t,{encoding:r,buffer:o,maxBuffer:i}),d=me(n,{encoding:r,buffer:o,maxBuffer:i*2});try{return await Promise.all([s,c,l,d])}catch(f){return Promise.all([{error:f,signal:f.signal,timedOut:f.timedOut},pe(e,c),pe(t,l),pe(n,d)])}};var yr=(async()=>{})().constructor.prototype,xr=["then","catch","finally"].map(e=>[e,Reflect.getOwnPropertyDescriptor(yr,e)]),he=(e,t)=>{for(let[n,r]of xr){let o=typeof t=="function"?(...i)=>Reflect.apply(r.value,t(),i):r.value.bind(t);Reflect.defineProperty(e,n,{...r,value:o})}return e},Kt=e=>new Promise((t,n)=>{e.on("exit",(r,o)=>{t({exitCode:r,signal:o})}),e.on("error",r=>{n(r)}),e.stdin&&e.stdin.on("error",r=>{n(r)})});var Wt=(e,t=[])=>Array.isArray(t)?[e,...t]:[e],wr=/^[\w.-]+$/,br=/"/g,vr=e=>typeof e!="string"||wr.test(e)?e:`"${e.replace(br,'\\"')}"`,zt=(e,t)=>Wt(e,t).join(" "),Vt=(e,t)=>Wt(e,t).map(n=>vr(n)).join(" "),Er=/ +/g,Yt=e=>{let t=[];for(let n of e.trim().split(Er)){let r=t[t.length-1];r&&r.endsWith("\\")?t[t.length-1]=`${r.slice(0,-1)} ${n}`:t.push(n)}return t};var Pr=1e3*1e3*100,Ir=({env:e,extendEnv:t,preferLocal:n,localDir:r,execPath:o})=>{let i=t?{...k.default.env,...e}:e;return n?pt({env:i,cwd:r,execPath:o}):i},Tr=(e,t,n={})=>{let r=Jt.default._parse(e,t,n);return e=r.command,t=r.args,n=r.options,n={maxBuffer:Pr,buffer:!0,stripFinalNewline:!0,extendEnv:!0,preferLocal:!1,localDir:n.cwd||k.default.cwd(),execPath:k.default.execPath,encoding:"utf8",reject:!0,cleanup:!0,all:!1,windowsHide:!0,...n},n.env=Ir(n),n.stdio=vt(n),k.default.platform==="win32"&&Zt.default.basename(e,".exe")==="cmd"&&t.unshift("/q"),{file:e,args:t,options:n,parsed:r}},ge=(e,t,n)=>typeof t!="string"&&!Qt.Buffer.isBuffer(t)?n===void 0?void 0:"":e.stripFinalNewline?re(t):t;function Cr(e,t,n){let r=Tr(e,t,n),o=zt(e,t),i=Vt(e,t);kt(r.options);let s;try{s=Se.default.spawn(r.file,r.args,r.options)}catch(g){let y=new Se.default.ChildProcess,x=Promise.reject(ae({error:g,stdout:"",stderr:"",all:"",command:o,escapedCommand:i,parsed:r,timedOut:!1,isCanceled:!1,killed:!1}));return he(y,x)}let c=Kt(s),l=Nt(s,r.options,c),d=Ft(s,r.options,l),f={isCanceled:!1};s.kill=$t.bind(null,s.kill.bind(s)),s.cancel=Ot.bind(null,s,f);let h=ht(async()=>{let[{error:g,exitCode:y,signal:x,timedOut:E},L,j,cn]=await Xt(s,r.options,d),xe=ge(r.options,L),we=ge(r.options,j),be=ge(r.options,cn);if(g||y!==0||x!==null){let ve=ae({error:g,exitCode:y,signal:x,stdout:xe,stderr:we,all:be,command:o,escapedCommand:i,parsed:r,timedOut:E,isCanceled:f.isCanceled,killed:s.killed});if(!r.options.reject)return ve;throw ve}return{command:o,escapedCommand:i,exitCode:0,stdout:xe,stderr:we,all:be,failed:!1,timedOut:!1,isCanceled:!1,killed:!1}});return Dt(s,r.options.input),s.all=Ht(s,r.options),he(s,h)}function en(e,t){let[n,...r]=Yt(e);return Cr(n,r,t)}var tn=require("fs"),nn=require("os"),ye=(0,a.getPreferenceValues)(),v=ye.brewPath&&ye.brewPath.length>0?ye.brewPath:(0,nn.cpus)()[0].model.includes("Apple")?"/opt/homebrew/bin/brew":"/usr/local/bin/brew";async function F(e){let{stdout:t,stderr:n}=await en(e);return{stdout:t,stderr:n}}async function R(){if(!(0,tn.existsSync)(v))return await(0,a.showToast)(a.ToastStyle.Failure,"Brew Executable Not Found",`Is brew installed at ${v}?`),[];let t=(await F(`${v} services list`)).stdout.split(`
`);if(t.length<=1)return(0,a.showToast)(a.ToastStyle.Failure,"Error Parsing Service Data","There are no services."),[];for(let r=0;r<t.length-1;r++)if(t[r].startsWith("Name")){t.splice(0,r+1);break}let n=[];for(let r of t){let o=r.trim().split(/ +/g);if(o.length<2)return(0,a.showToast)(a.ToastStyle.Failure,"Error Parsing Service Data","Service data could not be parsed."),[];let i=o[1];i==="none"&&(i="stopped"),o.length!==4&&o[1]==="started"&&(i="running"),n.push({name:o[0],status:i,user:o.length===4?o[2]:"",path:o.at(-1)??""})}return n}async function rn(e){let t=new a.Toast({style:a.ToastStyle.Animated,title:"Stopping Service",message:`Stopping ${e}`});t.show(),await F(`${v} services stop ${e}`);let n=await R();for(let r of n)r.name===e&&(r.status==="stopped"?(t.style=a.ToastStyle.Success,t.title="Stopped Service",t.message=`Stopped ${e}`):(t.style=a.ToastStyle.Failure,t.title="Error Stopping Service",t.message=`${e} could not be stopped properly`))}async function Ar(e){let t=new a.Toast({style:a.ToastStyle.Animated,title:"Starting Service",message:`Starting ${e}`});t.show(),await F(`${v} services start ${e}`);let n=await R();for(let r of n)r.name===e&&(r.status==="started"?(t.style=a.ToastStyle.Success,t.title="Started Service",t.message=`Started ${e}`):(t.style=a.ToastStyle.Failure,t.title="Error Starting Service",t.message=`${e} could not be started properly`))}async function on(e){let t=new a.Toast({style:a.ToastStyle.Animated,title:"Restarting Service",message:`Restarting ${e}`});t.show(),await F(`${v} services restart ${e}`);let n=await R();for(let r of n)r.name===e&&(r.status==="started"||r.status==="running"?(t.style=a.ToastStyle.Success,t.title="Restarted Service",t.message=`Restarted ${e}`):(t.style=a.ToastStyle.Failure,t.title="Error Restarting Service",t.message=`${e} could not be restarted properly`))}async function Gr(e){let t=new a.Toast({style:a.ToastStyle.Animated,title:"Running Service",message:`Running ${e}`});t.show(),await F(`${v} services run ${e}`);let n=await R();for(let r of n)r.name===e&&(r.status==="running"?(t.style=a.ToastStyle.Success,t.title="Ran Service",t.message=`Ran ${e}`):(t.style=a.ToastStyle.Failure,t.title="Error Running Service",t.message=`${e} could not be run properly`))}function Rr(e){return e==="started"||e==="running"?{source:a.Icon.Checkmark,tintColor:a.Color.Green}:e==="stopped"?{source:a.Icon.XmarkCircle,tintColor:a.Color.Red}:{source:a.Icon.ExclamationMark,tintColor:a.Color.Yellow}}function $r(e){return e.data.status==="started"||e.data.status==="running"?_jsx(a.ActionPanel,null,_jsx(a.ActionPanel.Section,{title:"Manage Service"},_jsx(a.ActionPanelItem,{title:"Stop Service",onAction:()=>rn(e.data.name)}),_jsx(a.ActionPanelItem,{title:"Restart Service",onAction:()=>on(e.data.name)})),_jsx(a.ActionPanel.Section,{title:"Plist"},_jsx(a.ShowInFinderAction,{title:"Reveal Plist File in Finder",path:e.data.path}),_jsx(a.CopyToClipboardAction,{title:"Copy Plist File Path",content:e.data.path}))):e.data.status==="stopped"?_jsx(a.ActionPanel,{title:"Manage Service"},_jsx(a.ActionPanelItem,{title:"Start Service",onAction:()=>Ar(e.data.name)}),_jsx(a.ActionPanelItem,{title:"Run Service",onAction:()=>Gr(e.data.name)})):_jsx(a.ActionPanel,{title:"Manage Service"},_jsx(a.ActionPanelItem,{title:"Stop Service",onAction:()=>rn(e.data.name)}),_jsx(a.ActionPanelItem,{title:"Restart Service",onAction:()=>on(e.data.name)}))}function sn(e){return _jsx(a.List,{isLoading:!e.services,searchBarPlaceholder:"Search for services..."},(e.services??[]).map(t=>_jsx(a.List.Item,{id:t.name,key:t.name,title:t.name,subtitle:t.status,accessoryTitle:t.user,icon:Rr(t.status),actions:_jsx($r,{data:t})})))}function an(){let[e,t]=(0,W.useState)();return(0,W.useEffect)(()=>{R().then(n=>t(n))}),_jsx(sn,{services:e})}module.exports=hn(Or);0&&(module.exports={});
