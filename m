Return-Path: <SRS0=6w/U=QT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D90C282C4
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 23:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E4E222C2
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 23:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfBLXKt (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 12 Feb 2019 18:10:49 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:49931 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbfBLXKt (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 12 Feb 2019 18:10:49 -0500
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id F2F9D100006;
        Tue, 12 Feb 2019 23:10:46 +0000 (UTC)
Date:   Wed, 13 Feb 2019 00:10:46 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] dt-bindings: rtc: Update for new chip in isl1208
 series
Message-ID: <20190212231046.GF10129@piout.net>
References: <20190212023225.2710-1-tpiepho@impinj.com>
 <20190212023225.2710-4-tpiepho@impinj.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212023225.2710-4-tpiepho@impinj.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 12/02/2019 02:34:05+0000, Trent Piepho wrote:
> Since this documents multiple chips controlled by the isl1208 driver,
> name it isil,isl1208.txt, as the convention is to use the base driver
> name in the bindings document for drivers with multiple devices.
> 
> Include all chips supported by this driver in the docs.  Make it
> clear which properties apply to which chips.
> 
> Expand documentation for existing isil,evienb property to explain
> operation in more detail.  Existing docs just describe it in terms of
> setting a bit in a register.
> 
> CC: Alessandro Zummo <a.zummo@towertech.it>
> CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>  .../devicetree/bindings/rtc/isil,isl1208.txt       | 38 ++++++++++++++++++++++
>  .../devicetree/bindings/rtc/isil,isl1219.txt       | 29 -----------------
>  2 files changed, 38 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt
>  delete mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
