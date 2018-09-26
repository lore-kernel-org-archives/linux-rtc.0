Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:57853 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0DFF (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 26 Sep 2018 23:05:05 -0400
Date: Wed, 26 Sep 2018 22:44:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Urs =?iso-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>
Cc: Urs =?iso-8859-1?Q?F=E4ssler?= <urs.fassler@bbv.ch>,
        a.zummo@towertech.it, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        lukas.stockmann@siemens.com, pascal.bach@siemens.com
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add capacitor selection for
 pcf85063
Message-ID: <20180926204435.GB8654@ravnborg.org>
References: <20180924112340.2685-1-urs.fassler@bbv.ch>
 <20180924121802.GC13455@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180924121802.GC13455@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Urs.

On Mon, Sep 24, 2018 at 02:18:02PM +0200, Alexandre Belloni wrote:
> Hello Urs,
> 
> You probably want to synchronize with Sam and his series:
> http://patchwork.ozlabs.org/project/rtc-linux/list/?series=64664&state=*

We will likely add a new property that can be used
in general. See above mail series (recent mails).

I will copy you on my next submission (in a week or so).

	Sam
