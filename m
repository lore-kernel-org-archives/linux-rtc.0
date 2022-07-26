Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F613C43334
	for <linux-rtc@archiver.kernel.org>; Tue, 26 Jul 2022 09:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiGZJ3l (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 26 Jul 2022 05:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiGZJ3l (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Jul 2022 05:29:41 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198A231919;
        Tue, 26 Jul 2022 02:29:39 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4B4AF10000F;
        Tue, 26 Jul 2022 09:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658827778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xIABaHkyxV6Y6alOCuhz1q6suNRfmWfXmIxgB+UeIr4=;
        b=L7w8bdmajmrWf4z7TGNbTMdSSy5cIzNexpC5nR5lSBruZ4/Q+LOQ7icvMtfFNgRtA2y94q
        X695E/ESceWDPughuiuKcvhN5j9vTbrazLCkL95mSgA+atTihd2J762C2KjLErJMCo7rUB
        rFTdeRQVYfNebu7Og/kTWXCDdDBGpVITTCAWkWORTEkq5WJJrW4UmsCDBybmXEhwP9D8SY
        L9hhZ6IoIGt0vu6NNg0LJWohNmGjR3ovxlIZAlnf1dIYvRTFLg9yq0p12yzzzQamSdEsMs
        fDG4T1tfMDEll45fDBLyzoe2eZKKYUDprLG3TRj1OIWu0LCz8J1zMHQTyQsLvw==
Date:   Tue, 26 Jul 2022 11:29:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        linux-rtc@vger.kernel.org
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, a.zummo@towertech.it,
        a.fatoum@pengutronix.de
Subject: Re: [PATCH -next v2] rtc: rv8803: fix missing unlock on error in
 rv8803_set_time()
Message-ID: <165882775797.3142114.10396983666770600717.b4-ty@bootlin.com>
References: <20220627080822.3881072-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627080822.3881072-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 27 Jun 2022 16:08:22 +0800, Yang Yingliang wrote:
> Add the missing unlock before return from function rv8803_set_time()
> in the error handling case.
> 
> 

Applied, thanks!

[1/1] rtc: rv8803: fix missing unlock on error in rv8803_set_time()
      commit: bb42b7e9e30e7a07b7cb6790a22dc758b0dc123e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
