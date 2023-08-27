Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600EEC83F01
	for <linux-rtc@archiver.kernel.org>; Sun, 27 Aug 2023 21:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjH0Vtk (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 27 Aug 2023 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjH0VtW (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 27 Aug 2023 17:49:22 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDA4119;
        Sun, 27 Aug 2023 14:49:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D439620003;
        Sun, 27 Aug 2023 21:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693172958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OZ157bRkPMqVfr+UZyuD+3fvs2HEAUxcsqT9/I9L4vw=;
        b=bIriiFklnSklu5OM8LQEhX9St5AF7Q/7DlvVAXmAhcumMsNmrNz76S8fW7tEaAn0AOBpdj
        ivlCh668ixI2xdvkym2N/3Ge5Eq3cYrJSdgIOz3zqqH/j5w54sZx5aSiTitFzKwizk+erq
        Dn2zIJ2/W3B7YF74zNqiU2iqgRgYROSfu0UoeVAh/SCmkBmerMuOif43hAs6zrC6Ntg0f+
        3uUr1JQZbhWOGGaJPIxqFtPULOg31sK8jzmjiWsjIHOXRzT6CPg47KTtvguYwtwrZ27V6x
        iEWC1zdhJaN1WBgK+kIjoKWSx4y0vLtFgORhg2JIhZE65sma/OZSA2TSAhQJYg==
Date:   Sun, 27 Aug 2023 23:49:16 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-rtc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] rtc: isl1208: Fix incorrect logic in isl1208_set_xtoscb()
Message-ID: <169317294155.537637.12191933080803526406.b4-ty@bootlin.com>
References: <20230817161038.407960-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817161038.407960-1-biju.das.jz@bp.renesas.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Thu, 17 Aug 2023 17:10:38 +0100, Biju Das wrote:
> The XTOSCB bit is not bit 0, but xtosb_val is either 0 or 1. If it is 1,
> test will never succeed. Fix this issue by using double negation.
> 
> While at it, remove unnecessary blank line from probe().
> 
> 

Applied, thanks!

[1/1] rtc: isl1208: Fix incorrect logic in isl1208_set_xtoscb()
      commit: f45d32d2cd183c09b6c9aa8689a91d6f2760b557

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
