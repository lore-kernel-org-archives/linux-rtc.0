Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:45422 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751338AbdH0Nrm (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 27 Aug 2017 09:47:42 -0400
Date: Sun, 27 Aug 2017 15:47:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Rob Herring <robh@kernel.org>, linux-rtc@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Roc He <hepeng@zidoo.tv>, devicetree@vger.kernel.org,
        ????????? <jiang.liqin@geniatech.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 1/3] dt-bindings: rtc: Add Realtek RTD1295
Message-ID: <20170827134729.GE13622@lunn.ch>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-2-afaerber@suse.de>
 <20170823002911.y35nn7jkt34dvjbc@rob-hp-laptop>
 <629b9ed0-7b2d-7c5c-20b8-17289a76f097@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <629b9ed0-7b2d-7c5c-20b8-17289a76f097@suse.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

> Thanks. Did you read the RFC question in the cover letter as well and
> have any comments? Downstream has an rtc-base-year = <2014>; property
> that I had left out in this RFC and due to your ack not included in v2.
> 
> Should we default to 2014 in the driver and add an optional base-year
> property once we encounter a diverging device, or should we make it
> required from the beginning? I did not spot any other rtc binding with
> such a property and would appreciate a clarification.

Hi Andreas

>From the perspective of the hardware, does it care what the base is?

A device using a different base will initially return the wrong
time. But once the correct time has been written back, it will be O.K.

This only becomes an issue if a device is used with different OSs,
which have different bases. Swapping back and forth between OSs then
becomes an issue.

KISS suggests not having a base in DT until it is actually
required. Since it is an additional property, it does not break
backwards compatibility when added.

	  Andrew
