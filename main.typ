// Metadati
#set document(
	title: "Storia greca",
	author: "Matteo Bertolino",
	description: "Appunti di storia greca",
	keywords: ("Storia", "Storia antica", "Storia greca"),
)

// Disposizione
#set page(paper: "a4", margin: 2.5cm, numbering: "i")
#set text(lang: "it", font: "Noto Serif", size: 12pt)
#set par(justify: true)
#set figure(numbering: none)
#show link: underline
#show heading.where(level: 1): set align(center)

// Ogni capitolo (livello 1) inizia su pagina nuova e azzera le note
#show heading.where(level: 1): it => {
	pagebreak(weak: true)
	counter(footnote).update(0)
	it
}

// Titolo e sottotitolo
#show title: set text(3em)
#page(numbering: none)[
	#place(top + center, figure(image(
		"img/thesmophoria.png",
		alt: "Dipinto a olio in formato orizzontale allungato: un corteo di donne vestite di bianco,
		disposte in gruppi, avanza in primo piano davanti a un muro orizzontale. Il dipinto è
		rappresentativo delle Tesmoforie, cerimonia segreta riservata alle donne in onore della dea
		Demetra Tesmofora"),
		caption: [Francis Davis Millet, _Thesmophoria_ (1894--1897), olio su tela, Provo, Brigham
		Young University Museum of Art.]
	))
	#align(center + horizon)[
		#title()
		#v(0.5em)
		#text(1.5em)[#context document.author.join(", ")]
	]
	#place(bottom + center, stack(
		dir: ttb,
		spacing: 0.5em,
		text(size: 0.5em)[Licenza #link("https://creativecommons.org/licenses/by-sa/4.0/deed.it")[CC
		BY-SA 4.0]],
		link("https://creativecommons.org/licenses/by-sa/4.0/deed.it", image(
			"img/CC-BY-SA.svg",
			alt: "Icone della licenza Creative Commons Attribuzione - Condividi allo stesso modo
			4.0",
		)),
	))
]

// Roba per gestire le intestazioni
#set heading(numbering: (..nums) => {
	let n = nums.pos()
	if n.len() == 1 {
		numbering("I.", n.first())
	} else if n.len() == 2 {
		numbering("1.", n.last())
	} else {
		numbering("1.1.", n.at(1), n.at(2))
	}
})
#show ref: it => {
	let el = it.element
	if el != none and el.func() == heading and el.numbering != none {
		let nums = counter(heading).at(el.location())
		let num = (numbering("I", nums.first()), ..nums.slice(1).map(str)).join(".")
		link(el.location())[#el.supplement #num]
	} else {
		it
	}
}

#outline(depth: 3)

// Numerazione delle pagine in numeri arabi
#set page(numbering: "1")
#counter(page).update(1)

// Premessa
#[
	#set heading(numbering: none)
	#include "capitoli/0-premessa.typ"
]

// Capitoli
#include "capitoli/1-arcaismo.typ"
#include "capitoli/2-tardo-arcaismo.typ"
#include "capitoli/3-classicismo.typ"
#include "capitoli/4-ellenismo.typ"
#include "capitoli/5-romanità.typ"

#bibliography("bibliografia.yaml", style: "modern-humanities-research-association-notes")
