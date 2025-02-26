import { LightningElement } from 'lwc';

export default class DiyParentComponent extends LightningElement {
    players = [
        {
            name: "Virat Kohli",
            description: "Virat Kohli had a dream. A dream like every other young kid in India to represent the country in the gentleman’s game. It is this vigor and fervor for the game of cricket that has helped this extremely talented young boy from Delhi to scale great heights at a very young age.",
            img: "/resource/ViratKohli",
            link: "https://en.wikipedia.org/wiki/Virat_Kohli",
        },
        {
            name: "Rohit Sharma",
            description: "An elegant and flamboyant batter, Rohit Sharma is one of India's premier batters who has endeared the cricket world with his elegance, timing and big hitting prowess.",
            img: "/resource/rohitsharma",
            link: "https://en.wikipedia.org/wiki/Rohit_Sharma",
        },
        {
            name: "Harmanpreet Kaur",
            description: "The all-rounder made her debut for India in the year 2009. Her batting and bowling prowess over the years got her in the limelight in International circuit, the latest feather on her cap being leading the Women's team in the Asia Cup 2016 that emerged as winners.",
            img: "/resource/harmanpreetkaur",
            link: "https://en.wikipedia.org/wiki/Harmanpreet_Kaur",
        }
    ]
}