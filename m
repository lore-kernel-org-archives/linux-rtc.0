Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB616C433F5
	for <linux-rtc@archiver.kernel.org>; Tue, 24 May 2022 23:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbiEXXYq (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 24 May 2022 19:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbiEXXYp (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 24 May 2022 19:24:45 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448C5D643
        for <linux-rtc@vger.kernel.org>; Tue, 24 May 2022 16:24:44 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EBB0A100004;
        Tue, 24 May 2022 23:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653434683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjrX0e3qN66/3LjvPu7R5ZMOv/5Pjz47R2U10HtMYWY=;
        b=oP5eCeniTY5FlOktAwLjZIuY+NPch8ohX977hNZzNI5dscdyFqn3u2X/s91FtVlNXxQnDZ
        Lbomf+qnkTuJT5JKl8g+FQ0q89DB7+0I1L2YCM5SfmmWzzWyRPXzBhKvs3r4mfmh6PEK/O
        9CuoLBMII5jVnEeKy56cADzGVyFJaZvLf5mEjUp/Xn1UKndi5918jXzshyh7hMpsDBIbND
        1/i5KFet7uqsNYIyFRSGIJ+6FR3P3czEkL6ABRQdo2blkemd7LqdmKkGhRy6smm8Kco2ea
        6aJaPCam463nxku+W5xbRO00U5Ybru2RhZyXjTrz6o1reKNKy8alH4H8zGxRcA==
Date:   Wed, 25 May 2022 01:24:42 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] rtc: rzn1: Fix a variable type
Message-ID: <165343466519.81341.3964965980344792165.b4-ty@bootlin.com>
References: <20220520082500.489248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520082500.489248-1-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Fri, 20 May 2022 10:25:00 +0200, Miquel Raynal wrote:
> The calculation in ->set_offset() handles both negative and positive
> offsets. The 'steps' variable will be checked to be in a specific [-x;
> +x] range, which means it must be a signed integer rather than
> unsigned.
> 
> This also fixes the following smatch warning:
> 
> [...]

Applied, thanks!

[1/1] rtc: rzn1: Fix a variable type
      commit: 3f3489248927a53fcfec571ff603163f6b676a46

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
