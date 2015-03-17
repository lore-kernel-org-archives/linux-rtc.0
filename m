Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 17 Mar 2015 20:32:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        a.zummo@towertech.it, rtc-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] rtc: at91rm9200: double locking bug in
 at91_rtc_interrupt()
Message-ID: <20150317173235.GM10964@mwanda>
References: <20150315104837.GC20691@mwanda>
 <1426606690-18947-1-git-send-email-nicolas.ferre@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426606690-18947-1-git-send-email-nicolas.ferre@atmel.com>
List-ID: <rtc-linux.googlegroups.com>

On Tue, Mar 17, 2015 at 04:38:10PM +0100, Nicolas Ferre wrote:
> Reported-also-by: David Dueck <davidcdueck@googlemail.com>

The point of tags is that you collect them by doing:
`git log | grep Reported-by: | sort | uniq -c | sort -rn` to see if you
are the winner.  It gives me an unfair advantage if you get creative
with David's tag.

regards,
dan carpenter
