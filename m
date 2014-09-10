Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 10 Sep 2014 17:57:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Johan Hovold <johan@kernel.org>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andrew Victor <linux@maxim.org.za>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] rtc: at91sam9: add DT bindings documentation
Message-ID: <20140910155732.GM2974@localhost>
References: <1409733934-14465-1-git-send-email-boris.brezillon@free-electrons.com>
 <1409733934-14465-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140910121424.GG2974@localhost>
 <20140910152019.111c4c01@bbrezillon>
 <20140910150702.GK2974@localhost>
 <20140910173532.0e8b1ef7@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140910173532.0e8b1ef7@bbrezillon>
List-ID: <rtc-linux.googlegroups.com>

On Wed, Sep 10, 2014 at 05:35:32PM +0200, Boris BREZILLON wrote:
> On Wed, 10 Sep 2014 17:07:02 +0200 Johan Hovold <johan@kernel.org> wrote:

> > Yes, this essentially what I suggested in the thread (and my last reply)
> > and relying on syscon rather than a custom driver seems like a good
> > idea. It would allow early access to the registers too with the recently
> > proposed changes. It would not guarantee any kind of exclusivity,
> > though, but I guess that's tolerable?
> 
> I know about the "mfd: syscon: Decouple syscon interface from platform
> devices" series, but I wonder why we would need to access GPBR
> registers during early boot stages. Do you have something in mind :-)?

Yeah, that's what I was referring to. In the thread from last year,
Jean-Christophe mentioned something about barebox using the
backup-registers. Not sure about the details, though.

Johan
