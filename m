Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDB8C27C76
	for <linux-rtc@archiver.kernel.org>; Wed, 25 Jan 2023 17:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbjAYRzk (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 25 Jan 2023 12:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYRzj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 25 Jan 2023 12:55:39 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE275FFF;
        Wed, 25 Jan 2023 09:55:37 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AB106100005;
        Wed, 25 Jan 2023 17:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674669336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DVn2ACjrj+7N2DNj/bk5rGlC0Twaltf0CHWhNg8myoM=;
        b=bIpChlGDObV5pTFnENoxAwcv2N5b1GqvdoRwobih3R4Jo3QLDb+k3qvwOSS0umifa8Yz6c
        M5KJRL0z5tTcVyPrgNJoFxysGvKC9ZghcYHweQqfnq7f9WCqBevruj+SvpvNnb0Z/33fPo
        GRAWjAmaoR5QaV18WXo1KMkDyFVcEwENNpU9sgElFz4WbwnhDzN9bRAcxoB835dFtLD70/
        vovRCOYm5Bjhwe9bTNshIfvA709mVP/HayKUhQkapqQB7aDR5Pn1NCFZkVwaSEWGsAtToU
        i9Vif5AqJIElke6i4nbrSDFSZHwjv/QzKMSlXcxfCtSX1apylpcezSGbRiDakg==
Date:   Wed, 25 Jan 2023 18:55:34 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Doug Berger <opendmb@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] rtc: brcmstb-waketimer: add RTC alarm irq
Message-ID: <167466931430.235977.6000970179317121729.b4-ty@bootlin.com>
References: <20230124201430.2502371-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124201430.2502371-1-opendmb@gmail.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Tue, 24 Jan 2023 12:14:28 -0800, Doug Berger wrote:
> Support is added for an interrupt that can be triggered from the
> brcmstb-waketimer hardware while the system is awake.
> 
> This interrupt allows the driver to pass the rtctest selftest.
> 
> Changes in v2:
>   - Squashed examples in the bindings document.
>   - Added Ack from Florian
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: rtc: brcm,brcmstb-waketimer: add alarm interrupt
      commit: 6cc7a8262b57db0a2ff6c141bb163c1395b7c4ef
[2/2] rtc: brcmstb-waketimer: allow use as non-wake alarm
      commit: 24304a87158aab01b4ccb9b2638c2c623a9a7bd4

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
