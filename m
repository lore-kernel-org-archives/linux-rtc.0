Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D91C83F11
	for <linux-rtc@archiver.kernel.org>; Sun, 27 Aug 2023 21:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjH0Vtk (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Sun, 27 Aug 2023 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjH0Vtf (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 27 Aug 2023 17:49:35 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8706B119;
        Sun, 27 Aug 2023 14:49:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C280240005;
        Sun, 27 Aug 2023 21:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693172971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X1A41XLxiGjxOXQQYjkjIEZWNYJ8/Qz7bBby00Az0O0=;
        b=EC5HzCEh0AvIIP0SqBdPnGdLACH4bx6Lk7ekPxEK09ugjkAOnj+ksdmjleZIg7iYu4FOp2
        IxxGyTyAnjEyok2rwnJGWA7Iy1PvdzVOLbR6mkGWTZBWlHxgaZ3cCZxxXAIRXMZw0mhZMn
        9tTIToDmEoI2IkLF09ZEcA6tgErqAW9kDAPB5jwisfyY+n0z9SZyEQpucKruQgMd6Tolc+
        ZFbxNYeVbDfh+6HjrPv8Mtn67EYLVzZ/OCh8uYdsSUA7eo3bULHJeAabPk3CKxHc7G0ULC
        Mg/IfiahTdnYXorMA4cIVRfIdTj1OZbELq+18CrLysrVoRl+jUMAgtaELOS18Q==
Date:   Sun, 27 Aug 2023 23:49:30 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove obsolete pattern in RTC SUBSYSTEM
 section
Message-ID: <169317294154.537637.1894827530197722432.b4-ty@bootlin.com>
References: <20230825053910.17941-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825053910.17941-1-lukas.bulwahn@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Fri, 25 Aug 2023 07:39:10 +0200, Lukas Bulwahn wrote:
> Commit d890cfc25fe9 ("rtc: ds2404: Convert to GPIO descriptors") removes
> the rtc-ds2404.h platform data and with that, there is no file remaining
> matching the pattern 'include/linux/platform_data/rtc-*'. Hence,
> ./scripts/get_maintainer.pl --self-test=patterns complains about a broken
> reference.
> 
> Remove the obsolete file pattern in the REAL TIME CLOCK (RTC) SUBSYSTEM.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: remove obsolete pattern in RTC SUBSYSTEM section
      commit: 45cc2a7de905a1f3bb38fb7d6f68a204c71630be

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
