Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:60847 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbeIHC0R (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Fri, 7 Sep 2018 22:26:17 -0400
Date: Fri, 7 Sep 2018 23:43:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Cc: =?iso-8859-1?Q?S=F8ren?= Andersen <san@skov.dk>
Subject: Re: [PATCH v1 1/5] dt-binding: rtci-pcf8523: add quartz_load property
Message-ID: <20180907214315.GA23873@ravnborg.org>
References: <20180822183555.GA24084@ravnborg.org>
 <20180907193508.24974-2-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180907193508.24974-2-sam@ravnborg.org>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi all.

> +Optional property:
> +- nxp,quartz_load_12.5pF: The capacitive load on the quartz is 12.5 pF,
> +  which differ from the default value of 7 pF
> +
> +Example:
> +
> +pcf8523: pcf8523@68 {
> +	compatible = "nxp,pcf85063";
> +	reg = <0x68>;
> +	nxp,quartz_load_12.5pF;
> +};

The property described in the bindings uses capital F.
But the intent was to use a lower-case f, so the property
is all lower-case.

Will fix in v2.
This goes for both this binding file and the nxp,pcf85063.txt.
The dts files and the implmentation uses lower-case f already.

	Sam
