%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CV
%
% Copyright (C) 2020 by Thijs van Ede
%
% Copying and distribution of this file, with or without modification,
% are permitted in any medium without royalty provided the copyright
% notice and this notice are preserved. This file is offered as-is,
% without any warranty.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create CV class
\ProvidesClass{cv}
% A4 11 pt by default
\LoadClass[11pt,a4paper]{article}

% Use bibliography
\usepackage[backend=biber,style=authoryear,sorting=none]{biblatex}
% For margin calculation
\usepackage{calc}
% Suppress page numbers
\pagestyle{empty}
% Set margins
\usepackage[left=0.75in,top=0.75in,right=0.75in,bottom=0.75in]{geometry}
% Use for links
\usepackage[colorlinks]{hyperref}
% Place tables where we want
\usepackage{float}
% Use fonts
\usepackage{fontawesome}
% For if-else statements
\usepackage{ifthen}
% Remove paragraph indentation
\usepackage[parfill]{parskip}
% Required for table formatting
\usepackage{placeins}
% Format table cells
\usepackage{makecell}
% Format table cells
\usepackage{multirow}
% Required for tables
\usepackage{tabularx}
% Use different colors
\usepackage[dvipsnames]{xcolor}
% Replace strings
\usepackage{xstring}
% Draw colored box
\usepackage{tcolorbox}

%-------------------------------------------------------------------------------
%	SET WHITESPACE
%-------------------------------------------------------------------------------
\def \namesize        {\huge}      % Size of the name at the top of the document
\def \subtitlesize    {\Large}     % Size of the name at the top of the document
\def \addressskip     {\smallskip} % The space between the two address (or phone/email) lines
\def \sectionlineskip {\medskip}   % The space above the horizontal line for each section
\def \nameskip        {\bigskip}   % The space after your name at the top
\def \sectionskip     {\bigskip}   % The space after the heading section
\setlength\tabcolsep{0pt}
\def \datemargin      {1.75cm}

%-------------------------------------------------------------------------------
%	DEFINE COLOURS
%-------------------------------------------------------------------------------
\def \colorheader {black}
\def \colorlink   {Maroon}
\def \colorpage   {white}
\def \colortext   {black}
\def \colortitle  {black}
\def \colortitlebg{\colorpage}

%-------------------------------------------------------------------------------
%	OPTIONS
%-------------------------------------------------------------------------------

\let \@modern \relax
% Specify modern
\DeclareOption{modern}{
	% Set modern to true
	\def \@modern {TRUE}

	% Set font to sans serif
	\renewcommand{\familydefault}{\sfdefault}
	\definecolor{dark}      {HTML}{372214}
	\definecolor{medium}    {HTML}{794228}
	\definecolor{light}     {HTML}{B8733A}
	\definecolor{background}{HTML}{BEC2CB}
	\definecolor{text}      {HTML}{34302C}

	% Set section colours
	\def \colorheader {medium}
	\def \colorlink   {light}
	\def \colorpage   {white}
	\def \colortext   {text}
	\def \colortitle  {white}
	\def \colortitlebg{medium}

	% Adapt geometry
	\newgeometry{left=0.5in,top=0.5in,right=0.5in,bottom=0.5in}
}

% Process options
\ProcessOptions\relax

%-------------------------------------------------------------------------------
%	LINKS
%-------------------------------------------------------------------------------

% Define link
\newcommand{\link}[2]{\href{#1}{\color{\colorlink}#2}}

%-------------------------------------------------------------------------------
%	CONTACT INFO
%-------------------------------------------------------------------------------

% Define name - empty by default
\def \@name {}
\def \name #1 {\def \@name {#1}}
\let \@subtitle \relax
\def \subtitle #1 {\def \@subtitle {#1}}

% Define conact information
\let \@address      \relax
\let \@zipcode      \relax
\let \@city         \relax
\let \@country      \relax
\def \address      #1 {\def \@address      {#1}}
\def \zipcode      #1 {\def \@zipcode      {#1}}
\def \cityname     #1 {\def \@cityname     {#1}}
\def \country      #1 {\def \@country      {#1}}

% Define organization
\let \@organization \relax
\let \@department   \relax
\let \@room         \relax
\def \organization #1 {\def \@organization {#1}}
\def \department   #1 {\def \@department   {#1}}
\def \room         #1 {\def \@room         {#1}}

% Define socials
\let \@email    \relax
\let \@github   \relax
\let \@linkedin \relax
\let \@scholar  \relax
\let \@website  \relax
\def \email    #1 {\def \@email    {#1}}
\def \github   #1 {\def \@github   {#1}}
\def \linkedin #1 {\def \@linkedin {#1}}
\def \scholar  #1 {\def \@scholar  {#1}}
\def \website  #1 {\def \@website  {#1}}

%-------------------------------------------------------------------------------
%	PRINT NAME AS HEADER
%-------------------------------------------------------------------------------

\let\ori@document=\document
\renewcommand{\document}{
	\ori@document  % Begin document
	% Set page color
	\pagecolor{\colorpage}

	\textbf{}
	\@ifundefined{@modern}{\vspace{-.75in}}{\vspace{-1in}}

	\begin{tcolorbox}[size=tight,oversize,sharp corners,
		colback=\colortitlebg,
		colframe=\colortitlebg,
		left=0.5in,
		right=0.5in,
		top=0.4in,
		bottom=-1cm,]
		% Set section color
		\color{\colortitle}

		\begingroup
		\hfil{\MakeUppercase{\namesize\bf \@name}}\hfil
		\nameskip\break
		\endgroup

		\begingroup
		\vspace{-.75cm}
		\hfil{\@ifundefined{@subtitle}{}{\subtitlesize \@subtitle\\}}\hfil
		\nameskip\break
		\endgroup
	\end{tcolorbox}

	\vspace{-.25cm} % Print the name specified with \name

	\color{\colortext}
}

%-------------------------------------------------------------------------------
%	SECTION FORMATTING
%-------------------------------------------------------------------------------

% Section in the CV
\renewcommand{\section}[1]{
	\color{\colorheader}
		\FloatBarrier
		\sectionskip
		\MakeUppercase{\textbf{#1}} % Section title
		\sectionlineskip
		\hrule % Horizontal line
	\color{\colortext}
}

%-------------------------------------------------------------------------------
%	CONTACT FORMATTING
%-------------------------------------------------------------------------------
\newcommand{\contact}{

	\section{Contact}
	\vspace{-.25cm}
	\begin{table}[!h]
		\begin{tabularx}{\textwidth}{X r}
			% Address column
			\makecell[cl]{
				\color{\colortext}
				\@ifundefined{@organization}{}{\@organization\\}
				\color{\colortext}
				\@ifundefined{@department}  {}{\@department\\}
				\color{\colortext}
				\@ifundefined{@room}        {}{\@room\\}
				\color{\colortext}
				\@ifundefined{@address}     {}{\@address\\}
				\color{\colortext}
				\@ifundefined{@zipcode}     {}{\@zipcode\@ifundefined{@cityname}{\\}{,}}
				\color{\colortext}
				\@ifundefined{@cityname}    {}{\@cityname\\}
				\color{\colortext}
				\@ifundefined{@country}     {}{\@country\\}
			}

			&

			% Socials column
			\makecell[cr]{
				% Print email if given
				\@ifundefined{@email}{}{
					\link{mailto:\@email}{\@email} {\faEnvelope \hspace*{-.05cm}}\\}
				% Print scholar if given
				\@ifundefined{@scholar}{}{
					\link{\@scholar}{\@name} {\hspace*{-.05cm}\faGraduationCap \hspace*{-.1cm}}\\}
				% Print linkedin if given
				\@ifundefined{@linkedin}{}{
					\link{https://linkedin.com\@linkedin}{\@linkedin} \faLinkedin\\}
				% Print github if given
				\@ifundefined{@github}{}{
					\link{https://github.com/\@github}{\@github} \faGithub\\}
				% Print website if given
				\@ifundefined{@website}{}{
					\link{\@website}{\@website} \faGlobe\\}
			}
		\end{tabularx}
	\end{table}
	\vspace{-.25cm}
}

%-------------------------------------------------------------------------------
%	SECTION ITEMS FORMATTING
%-------------------------------------------------------------------------------

\newcommand{\cvitem}[4]{
	\begin{table}[H]
		\color{\colortext}
		\begin{tabularx}{\textwidth}{p{\datemargin} X}
			\multirow[t]{2}{\datemargin}{#1} & \hspace{12pt} \textbf{#3} \hfill \emph{#2}\\
			   & \hspace{12pt} \makecell[{{p{\textwidth - 2.25cm}}}]{#4}
		\end{tabularx}
	\end{table}
	\vspace{-.2cm}
}

\newcommand{\cvitemshort}[3]{
	\vspace{-.2cm}
	\begin{table}[H]
		\color{\colortext}
		\begin{tabularx}{\textwidth}{p{\datemargin} X}
			#1 & \hspace{12pt} \makecell[tl]{#3} \hfill \emph{#2}\\
		\end{tabularx}
	\end{table}
	\vspace{-.2cm}
}

\newcommand{\reference}[3]{
	\vspace{-.2cm}
	\begin{table}[H]
		\color{\colortext}
		\begin{tabularx}{\textwidth}{p{4cm} X}
			\textbf{#1} & \hspace{12pt} #3 \hfill \emph{#2}\\
		\end{tabularx}
	\end{table}
	\vspace{-.2cm}
}
