<h1 id="h.m8xswz2br8cd" class="c39"><span class="c32 c5 c35">Codebreaker - Console</span></h1>
<h2 id="h.xk6yw344nayg" class="c19"><span class="c22 c7">Introduction</span></h2>
<p class="c21"><span class="c7">You need to build an application that helps a user to play the </span><span class="c5">Codebreaker game</span><span class="c0">&nbsp;through user interaction with a console.</span></p>
<p class="c21"><span class="c0">It means you need to build a &ldquo;console app&rdquo;.</span></p>
<p class="c21"><span class="c0">In most cases, the application must ask questions and the user must answer them/choose one of the listed options.</span></p>
<p class="c21"><span class="c23 c7 c20">NOTE: you must handle all the answers if a user didn&rsquo;t enter the format/answer you expected</span></p>
<p class="c21"><span class="c0">All the code must be covered with specs</span></p>
<p class="c13">&nbsp;</p>
<h2 id="h.4n5z5wis73ug" class="c19"><span class="c22 c7">Game Rules</span></h2>
<ul class="c6 lst-kix_at4fuqiu7arp-0 start">
<li class="c1 c14"><span class="c5">Codebreaker</span><span class="c7">&nbsp;is a logic game in which a code-breaker tries to break a </span><span class="c5">secret code</span><span class="c7">&nbsp;created by a code-maker. The </span><span class="c5">codemaker</span><span class="c7">, which will be played by the application we&rsquo;re going to write, creates a secret code of </span><span class="c5">four numbers</span><span class="c7">&nbsp;between </span><span class="c2">1 and 6.</span></li>
<li class="c1 c14"><span class="c7">The codebreaker </span><span class="c5">gets</span><span class="c7">&nbsp;some number of chances to break the code (depends on chosen difficulty). In each turn, the </span><span class="c5">codebreaker</span><span class="c7">&nbsp;makes a guess of </span><span class="c5">4</span><span class="c7">&nbsp;numbers. The </span><span class="c5">codemaker</span><span class="c7">&nbsp;then marks the guess with up to 4 signs - </span><span class="c5 c30">+</span><span class="c7">&nbsp;or </span><span class="c5 c17">-</span><span class="c7">&nbsp;or </span><span class="c5">empty spaces</span><span class="c0">.</span></li>
<li class="c1 c14"><span class="c7">A </span><span class="c5">+</span><span class="c0">&nbsp;indicates an exact match: one of the numbers in the guess is the same as one of the numbers in the secret code and in the same position. For example:</span></li>
</ul>
<p class="c1"><span class="c5">Secret number</span><span class="c0">&nbsp;- 1234</span></p>
<p class="c1"><span class="c5">Input number</span><span class="c0">&nbsp;- 6264</span></p>
<p class="c1"><span class="c5">Number of pluses</span><span class="c0">&nbsp;- 2 (second and fourth position)</span></p>
<ul class="c6 lst-kix_at4fuqiu7arp-0">
<li class="c1 c14"><span class="c7">A </span><span class="c5">-</span><span class="c0">&nbsp;indicates a number match: one of the numbers in the guess is the same as one of the numbers in the secret code but in a different position. For example:</span></li>
</ul>
<p class="c1"><span class="c5">Secret number</span><span class="c0">&nbsp;- 1234</span></p>
<p class="c1"><span class="c5">Input number</span><span class="c0">&nbsp;- 6462</span></p>
<p class="c1"><span class="c5">Number of minuses</span><span class="c0">&nbsp;- 2 (second and fourth position)</span></p>
<ul class="c6 lst-kix_at4fuqiu7arp-0">
<li class="c1 c14"><span class="c0">An empty space indicates that there is not a current digit in a secret number.</span></li>
<li class="c1 c14"><span class="c7">If </span><span class="c5">codebreaker</span><span class="c7">&nbsp;inputs the exact number as a secret number - </span><span class="c5">codebreaker</span><span class="c0">&nbsp;wins the game. If all attempts are spent - codebreaker loses.</span></li>
<li class="c1 c14"><span class="c5">Codebreaker</span><span class="c0">&nbsp;also has some number of hints(depends on chosen difficulty). If a user takes a hint - he receives back a separate digit of the secret code.</span></li>
</ul>
<p class="c13">&nbsp;</p>
<p class="c13">&nbsp;</p>
<p class="c13">&nbsp;</p>
<h2 id="h.r4e2yhhwimza" class="c19"><span class="c22 c7">Codebreaker Examples Matrix</span></h2>
<p class="c13">&nbsp;</p>
<p><a id="t.350d5924bf2786fddf2ab86e1a9a27c83f9bec9b"></a><a id="t.0"></a></p>
<table class="c33">
<tbody>
<tr class="c4">
<td class="c11 c15" colspan="1" rowspan="1">
<p class="c18"><span class="c2">Secret Code</span></p>
</td>
<td class="c11 c15" colspan="1" rowspan="1">
<p class="c18"><span class="c2">Input</span></p>
</td>
<td class="c11 c15" colspan="1" rowspan="1">
<p class="c18"><span class="c2">Output</span></p>
</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6543</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">5643</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">++--</span></p>
</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6543</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6411</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">+-</span></p>
</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6543</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6544</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">+++</span></p>
</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6543</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">3456</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">----</span></p>
</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6543</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6666</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">+</span></p>
</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6543</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">2666</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">-</span></p>
</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6543</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">2222</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">&nbsp;</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">6666</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">1661</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">++</span></p>
</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">1234</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">3124</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">+---</span></p>
</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">1234</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">1524</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">++-</span></p>
</td>
</tr>
<tr class="c4">
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">1234</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c0">1234</span></p>
</td>
<td class="c11" colspan="1" rowspan="1">
<p class="c8"><span class="c7">++++</span><span class="c2">&nbsp;(win)</span></p>
</td>
</tr>
</tbody>
</table>
<p class="c13">&nbsp;</p>
<p class="c13">&nbsp;</p>
<h2 id="h.q6lakfjvwvjb" class="c19"><span class="c22 c7">User Game Scenario</span></h2>
<ul class="c6 lst-kix_j1nli71lkw7w-0 start">
<li class="c26 c14">
<h3 id="h.qol9e5v3dsg9" style="display: inline;"><span class="c34 c7 c17">Start a console</span></h3>
</li>
</ul>
<ul class="c6 lst-kix_j1nli71lkw7w-1 start">
<li class="c9 c14"><span class="c7">I see &ldquo;</span><span class="c5">introduction message</span><span class="c0">&rdquo; - some text with &ldquo;welcome&rdquo; text.</span></li>
<li class="c9 c14"><span class="c7">I also see text with the proposed option to select(enter) one of several possible scenarios: </span><span class="c5">start</span><span class="c7">, </span><span class="c5">rules</span><span class="c7">, </span><span class="c5">stats</span><span class="c7">, </span><span class="c5">exit</span><span class="c0">.</span></li>
<li class="c9 c14"><span class="c7">If I answer &ldquo;</span><span class="c5">startttt</span><span class="c0">&rdquo; on console question and receives back text like:</span></li>
</ul>
<p class="c9"><span class="c7">&ldquo;</span><span class="c7 c20">You have passed unexpected command. Please choose one from listed commands</span><span class="c0">&rdquo;</span></p>
<p class="c13 c28">&nbsp;</p>
<p class="c9"><span class="c0">And I also see text with proposed options one more time.</span></p>
<ul class="c6 lst-kix_j1nli71lkw7w-1">
<li class="c9 c14"><span class="c7">If I answer &ldquo;</span><span class="c5">exit</span><span class="c7">&rdquo; - I leave the game console with some &ldquo;</span><span class="c5">goodbye</span><span class="c0">&rdquo; message.</span></li>
<li class="c9 c14"><span class="c7">If I answer &ldquo;</span><span class="c5">rules</span><span class="c7">&rdquo; &nbsp;- I see the rules of </span><span class="c2">Codebreaker.</span></li>
</ul>
<p class="c13 c28">&nbsp;</p>
<p class="c9"><span class="c0">And I &nbsp;also see text with proposed options one more time</span></p>
<ul class="c6 lst-kix_j1nli71lkw7w-1">
<li class="c9 c14"><span class="c7">If I answer &ldquo;stats&rdquo; - I see the table of </span><span class="c5">codebreakers</span><span class="c0">, ordered by Difficulty (from high to low), attempts used(from low to high), hints used(from low to high)</span></li>
</ul>
<p class="c13 c28">&nbsp;</p>
<p class="c9"><span class="c0">The table consists of next column names:</span></p>
<ul class="c6 lst-kix_uy9qbztiao5a-0 start">
<li class="c27 c14"><span class="c5">Rating</span><span class="c7">&nbsp;</span><span class="c23 c7 c20">(the position from 1 to total codebreakers number)</span></li>
<li class="c27 c14"><span class="c2">Name</span></li>
<li class="c27 c14"><span class="c2">Difficulty</span></li>
<li class="c27 c14"><span class="c2">Attempts Total</span></li>
<li class="c27 c14"><span class="c2">Attempts Used</span></li>
<li class="c14 c27"><span class="c2">Hints Total</span></li>
<li class="c27 c14"><span class="c2">Hints Used</span></li>
</ul>
<p class="c31"><span class="c2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c9"><span class="c0">And I also see text with proposed options one more time</span></p>
<p class="c13 c28">&nbsp;</p>
<ul class="c6 lst-kix_j1nli71lkw7w-1">
<li class="c9 c14"><span class="c7">If I press &ldquo;</span><span class="c5">start</span><span class="c7">&rdquo; - I start a </span><span class="c2">game registration</span></li>
</ul>
<p class="c13">&nbsp;</p>
<ul class="c6 lst-kix_9py96owhpgpz-0 start">
<li class="c26 c14">
<h3 id="h.6njoa92f6c5h" style="display: inline;"><span class="c7 c17 c34">Game registration</span></h3>
</li>
</ul>
<ul class="c6 lst-kix_9py96owhpgpz-1 start">
<li class="c9 c14"><span class="c0">At any step, I am able to input &ldquo;exit&rdquo; and leave the game console</span></li>
<li class="c9 c14"><span class="c7">I am prompted to enter my name. A name is validatable. See </span><span class="c2">Validations</span></li>
</ul>
<p class="c13 c28">&nbsp;</p>
<p class="c9"><span class="c0">If the name is not valid - I am informed that it is wrong in my input and I am prompted to enter my name until my name would be valid </span></p>
<ul class="c6 lst-kix_9py96owhpgpz-1">
<li class="c9 c14"><span class="c0">Next I a prompted to choose the difficulty:</span></li>
</ul>
<p class="c13">&nbsp;</p>
<p class="c9"><span class="c0">By default your game has 3 difficulties(you can change something if you want) :</span></p>
<p class="c9"><span class="c5">Easy</span><span class="c0">&nbsp;- 15 attempts. 2 hints</span></p>
<p class="c9"><span class="c5">Medium</span><span class="c0">&nbsp;- 10 attempts. 1 hint</span></p>
<p class="c9"><span class="c5">Hell</span><span class="c0">&nbsp;- 5 attempts. 1 hint</span></p>
<ul class="c6 lst-kix_9py96owhpgpz-1">
<li class="c9 c14"><span class="c0">I am prompted to choose the difficulty until I choose one of the listed difficulties</span></li>
</ul>
<p class="c13">&nbsp;</p>
<ul class="c6 lst-kix_9py96owhpgpz-0">
<li class="c14 c26">
<h3 id="h.jsao35duwjv8" style="display: inline;"><span class="c34 c7 c17">Game process</span></h3>
</li>
</ul>
<ul class="c6 lst-kix_9py96owhpgpz-1 start">
<li class="c9 c14"><span class="c7">I am prompted to enter </span><span class="c5">my guess</span><span class="c7">&nbsp;of secret code(See </span><span class="c5">Validations</span><span class="c7">), take a &ldquo;</span><span class="c5">hint</span><span class="c7">&rdquo;, or press &ldquo;</span><span class="c5">exit</span><span class="c0">&rdquo;</span></li>
</ul>
<p class="c13 c28">&nbsp;</p>
<p class="c9"><span class="c7">If I input my guess in the </span><span class="c5">wrong format</span><span class="c7">&nbsp;OR if I input some </span><span class="c5">unexpected command</span><span class="c7">&nbsp;- I </span><span class="c5">must be notified</span><span class="c0">&nbsp;about that and I also must be prompted to enter one of the valid commands - one more time.</span></p>
<p class="c13 c28">&nbsp;</p>
<p class="c9"><span class="c7">For an erroneous command or guess in the wrong format, an </span><span class="c5">attempt is not taken away</span><span class="c0">.</span></p>
<ul class="c6 lst-kix_9py96owhpgpz-1">
<li class="c9 c14"><span class="c7">If I press &ldquo;</span><span class="c5">hint</span><span class="c7">&rdquo; - the </span><span class="c5">digit</span><span class="c7">&nbsp;from my </span><span class="c5">secret code</span><span class="c7">&nbsp;must be received back (without a position) if there are </span><span class="c2">any hints left.</span></li>
</ul>
<p class="c13 c28">&nbsp;</p>
<p class="c9"><span class="c7">If I take a hint </span><span class="c5">2 or more times</span><span class="c7">&nbsp;- I must receive back </span><span class="c5">different digits of a secret number</span><span class="c0">, so I mustn&rsquo;t receive the same digit number.</span></p>
<p class="c1"><span class="c0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
<p class="c1"><span class="c7">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If there are </span><span class="c5">no hints left </span><span class="c7">- I must see the </span><span class="c5">corresponding text</span><span class="c0">.</span></p>
<ul class="c6 lst-kix_9py96owhpgpz-1">
<li class="c9 c14"><span class="c7">If I </span><span class="c5">make a guess</span><span class="c7">&nbsp;and this </span><span class="c5">guess is valid</span><span class="c7">&nbsp;(See </span><span class="c5">Validations</span><span class="c7">) I receive back a </span><span class="c5">response</span><span class="c7">&nbsp;that consists of &lsquo;</span><span class="c5">+</span><span class="c7">&rsquo;, &lsquo;</span><span class="c5">-</span><span class="c0">&rsquo;, and &lsquo;&rsquo;.</span></li>
</ul>
<p class="c13 c36">&nbsp;</p>
<p class="c9"><span class="c5">Note</span><span class="c7">: </span><span class="c7 c20">Signs in the answer must not coincide with the corresponding positions in the </span><span class="c3">secret code</span><span class="c7 c20 c23">. First, I must see some amount of &lsquo;+&rsquo; if they present and then - some amount of &lsquo;-&rsquo; if the present. </span></p>
<p class="c13 c28">&nbsp;</p>
<p class="c9"><span class="c7 c20">For example &lsquo;</span><span class="c3">++-</span><span class="c7 c20">&rsquo; or &lsquo;</span><span class="c3">+-</span><span class="c7 c20">&rsquo; or &lsquo;</span><span class="c3">---</span><span class="c23 c7 c20">&rsquo;.</span></p>
<p class="c13">&nbsp;</p>
<ul class="c6 lst-kix_9py96owhpgpz-1">
<li class="c9 c14"><span class="c7">The game process continues until I </span><span class="c5">guess the secret code</span><span class="c7">&nbsp;or I </span><span class="c5">have not any attempts</span><span class="c0">&nbsp;left</span></li>
</ul>
<ul class="c6 lst-kix_9py96owhpgpz-0">
<li class="c26 c14">
<h3 id="h.ia7r1x6plqc" style="display: inline;"><span class="c34 c7 c17">Game summary</span></h3>
</li>
</ul>
<ul class="c6 lst-kix_9py96owhpgpz-1 start">
<li class="c9 c14"><span class="c7">If I guessed the secret code - I </span><span class="c5">win</span><span class="c0">.</span></li>
</ul>
<p class="c9"><span class="c0">I see the correct answer.</span></p>
<p class="c9"><span class="c7">I am asked for </span><span class="c5">saving the results</span><span class="c0">&nbsp;of the game</span></p>
<p class="c9"><span class="c7">I am prompted to </span><span class="c5">start a new game</span></p>
<ul class="c6 lst-kix_9py96owhpgpz-1">
<li class="c9 c14"><span class="c7">If I have not any attempts left - I </span><span class="c5">lose</span><span class="c0">.</span></li>
</ul>
<p class="c9"><span class="c0">I see the correct answer.</span></p>
<p class="c9"><span class="c7">I am prompted to </span><span class="c2">start a new game</span></p>
<h2 id="h.9bewjbnlk3hw" class="c19"><span class="c7 c22">Validations</span></h2>
<ul class="c6 lst-kix_ttb9qeceh4y-0 start">
<li class="c1 c14"><span class="c5">Name</span><span class="c0">&nbsp;- string, required, min length - 3 symbols, max length - 20 1</span></li>
<li class="c1 c14"><span class="c5">Guess</span><span class="c0">&nbsp;- number, required, length - 4 digits, each digit is a number in the range 1-6</span></li>
</ul>
<h2 id="h.t68le0jodsk0" class="c19"><span class="c22 c7">Technical Requirements</span></h2>
<ul class="c6 lst-kix_j5q2lfkd5lun-0 start">
<li class="c1 c14"><span class="c7 c25 c32">Your code is lintered with Rubocop/Fasterer and has zero number of errors/warning.</span></li>
</ul>
<p class="c1"><span class="c7 c25">You can use </span><span class="c7 c25 c29"><a class="c10" href="https://www.google.com/url?q=https://github.com/brigade/overcommit&amp;sa=D&amp;ust=1574258270891000">Overcommit</a></span><span class="c7 c25">&nbsp;gem</span></p>
<ul class="c6 lst-kix_j5q2lfkd5lun-0">
<li class="c1 c14"><span class="c12 c7">Project must have a &nbsp;hierarchy. Don't put all the files in the root of the project. </span></li>
<li class="c1 c14"><span class="c7 c12">Intentations and &ldquo;pretty&rdquo; view of a code</span></li>
<li class="c1 c14"><span class="c12 c7">Project must have Pull Request on Git repository opened</span></li>
<li class="c1 c14"><span class="c12 c7">All branches/commits/modules/classes/methods/variables/files should be named correctly</span></li>
<li class="c1 c14"><span class="c12 c7">Your code is fully covered with specs.</span></li>
</ul>
<p class="c1"><span class="c7 c16">Coverage level </span><span class="c12 c5">must be &gt; 95%</span></p>
<p class="c1"><span class="c16 c7">Use</span><span class="c16 c5">&nbsp;</span><span class="c29 c16 c5"><a class="c10" href="https://www.google.com/url?q=https://github.com/colszowka/simplecov&amp;sa=D&amp;ust=1574258270892000">coverage</a></span><span class="c16 c5">&nbsp;</span><span class="c12 c7">gem in order to control the flow.</span></p>
<ul class="c6 lst-kix_7kepca5smvvs-0 start">
<li class="c1 c14"><span class="c16 c7 c20">Additional task(not required)</span><span class="c16 c7">: Add </span><span class="c29 c16 c7"><a class="c10" href="https://www.google.com/url?q=https://circleci.com/&amp;sa=D&amp;ust=1574258270892000">CircleCI</a></span><span class="c12 c7">&nbsp;to your project.</span></li>
</ul>
<p class="c13">&nbsp;</p>
