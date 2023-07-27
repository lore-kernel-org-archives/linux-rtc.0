Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF26EB64DD
	for <linux-rtc@archiver.kernel.org>; Thu, 27 Jul 2023 21:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjG0VId (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjG0VIc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 27 Jul 2023 17:08:32 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA3B30DC;
        Thu, 27 Jul 2023 14:08:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5789040002;
        Thu, 27 Jul 2023 21:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690492109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkMgJBSJNDhhZeYAixxZuRbqJTtK5lAzd8EABfZ1DrI=;
        b=FU556oJb+Zjmwsa/ssx/yqcUt+OoWq60kqtxcEq3U/dIkM/hz6szhAZz/D2sudsCNGxouq
        /bWuOUPb7ATSU5EnAcB4mABGJRH3q5qikcRfLynpxaSzjLymIJypfCvZN+2P+rajNWVJkJ
        5O+RmnuWT3SxNHY2cg3zBe5X1MwVqFEDPqAVBXqqZ1SaJGECnEjL6j7ejesK1Ripx6nUSO
        69N5D93O91fvw2b0/216A7w2Omx5pWK2VF13hwF8La0G99WDSZWBgeLRDCMxDGoRudFQU/
        UygttwJ/OLNlIbymE1q/x7UI85MxKAHVCv/0JUJ0QWalKO4pOj0/hWzLnk6JOQ==
Date:   Thu, 27 Jul 2023 23:08:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     linux-rtc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] rtc: isl1208: Simplify probe()
Message-ID: <169049207819.464219.1102246575183992.b4-ty@bootlin.com>
References: <20230710114747.106496-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710114747.106496-1-biju.das.jz@bp.renesas.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Mon, 10 Jul 2023 12:47:47 +0100, Biju Das wrote:
> Simplify the probe() by replacing of_device_get_match_data() and
> i2c_match_id() by i2c_get_match_data() as we have similar I2C
> and DT-based matching table.
> 
> 

Applied, thanks!

[1/1] rtc: isl1208: Simplify probe()
      commit: b7f73b6e921b457a222e86cf53fe3950c6b5aed5

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
