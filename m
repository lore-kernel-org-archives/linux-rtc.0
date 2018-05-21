Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37091 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbeEUIj6 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 21 May 2018 04:39:58 -0400
Date: Mon, 21 May 2018 10:39:55 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        kernel@pengutronix.de
Subject: race related to rtc_device_unregister [Was: Re: [PATCH] rtc:
 pcf2127: add support for accessing internal static] RAM
Message-ID: <20180521083955.dcnpwzlw22xfg3uf@pengutronix.de>
References: <20180520133723.30547-1-u.kleine-koenig@pengutronix.de>
 <20180520180520.GC23730@piout.net>
 <20180520184001.xcgn4b6aijvfzu37@pengutronix.de>
 <20180520200809.GE23730@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180520200809.GE23730@piout.net>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hello,

On Sun, May 20, 2018 at 10:08:09PM +0200, Alexandre Belloni wrote:
> On 20/05/2018 20:40:01+0200, Uwe Kleine-König wrote:
> > On Sun, May 20, 2018 at 08:05:20PM +0200, Alexandre Belloni wrote:
> > > You must not return an error here once devm_rtc_device_register has
> > > succeeded.
> > 
> > Why? Sounds like something that should be fixed.
> > 
> 
> This is the explanation:
> http://patchwork.ozlabs.org/patch/324263/

So open() should get a reference to the module to ensure it is not freed
while the dev is accessed. The same can happen when the driver is
manually unbound while the device is accessed (which is also fixed when
open() takes a reference).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
