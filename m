Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: David Dueck <davidcdueck@googlemail.com>, boris.brezillon@free-electrons.com, rtc-linux@googlegroups.com, a.zummo@towertech.it, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com
Subject: Re: [PATCH] rtc: at91rm9200: Fix locking in interrupt handler
Date: Sun, 15 Mar 2015 13:10:25 +0100
Message-ID: <12923849.5UvAiHoKLG@wuerfel>
In-Reply-To: <1426416887-3450-1-git-send-email-davidcdueck@googlemail.com>
References: <1426416887-3450-1-git-send-email-davidcdueck@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <rtc-linux.googlegroups.com>

On Sunday 15 March 2015 11:54:47 David Dueck wrote:
> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> 

Please always describe why a change is done. Was this a recent
regression? What caused it?

	Arnd
