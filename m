Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE37C433F5
	for <linux-rtc@archiver.kernel.org>; Tue, 24 May 2022 23:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbiEXXWw (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 24 May 2022 19:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbiEXXWu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 24 May 2022 19:22:50 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196B95C879;
        Tue, 24 May 2022 16:22:48 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AA0B840002;
        Tue, 24 May 2022 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653434567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TpOhdQdmfWIeiF+2SheY+AZfeTF6hnE2HG99ek4+4A8=;
        b=JYrX3SOp2+aqW6WTG6quDDSCC4kitSB4Ytgq2jAUVBfIyS/NZsfr97FWYRBaEGsUwlY7Xd
        dp7F5fotpyxBZFG6ubn8mCrgb2Fmzg6tmmw+bE65hBudbty2VkPcrdfdRshqfkSWGtTufi
        139jFftSEegkkZMtcfqeWhv0E+Gh9tyAathOxt3KqkpK9EO1RTB2ECaZOFhQtgc/dw2Hx7
        MWJceecZYYU+MuUUs+04ZRqZwuLC/KClNnclss/MeXqb6UM/2hQ2C8QANK4hrBjQ8xALbP
        70ARLyGbLJOh5KYVcFmid3W31Yg/1wnIFSMIIX0ms5S51juyucKfOSZdooTbIg==
Date:   Wed, 25 May 2022 01:22:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: rzn1: Fix error code in probe
Message-ID: <165343454397.80986.4832495351710090018.b4-ty@bootlin.com>
References: <YoZMg1dmHHSJEfE9@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZMg1dmHHSJEfE9@kili>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, 19 May 2022 16:56:19 +0300, Dan Carpenter wrote:
> There is a copy and paste error so this code returns the wrong variable.
> 
> 

Applied, thanks!

[1/1] rtc: rzn1: Fix error code in probe
      commit: 0b6da785130d9e8cf33d001a7bf08a979c87d019

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
