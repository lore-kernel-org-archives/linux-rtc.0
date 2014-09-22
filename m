Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 22 Sep 2014 17:18:54 +0200
From: Johan Hovold <johan@kernel.org>
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Andrew Victor <linux@maxim.org.za>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/9] rtc: at91sam9: make use of syscon/regmap to
 access GPBR registers
Message-ID: <20140922151854.GI5237@localhost>
References: <1411377058-26155-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411377058-26155-6-git-send-email-boris.brezillon@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411377058-26155-6-git-send-email-boris.brezillon@free-electrons.com>
List-ID: <rtc-linux.googlegroups.com>

On Mon, Sep 22, 2014 at 11:10:54AM +0200, Boris BREZILLON wrote:
> The GPBR registers are not part of the RTT block and thus should not be
> defined in the reg property of the rtt node.
> 
> Use syscon to provide a proper DT representation and reference the GPBR
> syscon device in a new "atmel,time-reg" property which store both the

You forgot to update the commit message with the new property name.

Johan
