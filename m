Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5D7C4332F
	for <linux-rtc@archiver.kernel.org>; Thu, 13 Oct 2022 21:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJMVbd (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiJMVbc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 13 Oct 2022 17:31:32 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713B9155D89;
        Thu, 13 Oct 2022 14:31:31 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E76B1100006;
        Thu, 13 Oct 2022 21:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665696689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iNJDGNcwZQZZBllRv+opgnsC0nRpqrGKRVfGP3YMRSc=;
        b=ehpGfxwwQ9SiAztkiIgt5uMwhP/HVEyOrNIIkhSHVNOy17XPwfKww47o7R6R7g/ucgHWVY
        FhfPNiWQiN0qreVHeohwCuPQnSemdm6/wfntMv5b7bUvGLl632NheQ/LxnZA9tWF+PC0wt
        RKmjH5lh4tibcv8HwAhzkyfRILfHS5GNKJG07TGY3i0/IrI0mAsbTPG6v8kej3jteMUmsG
        Ifk3sytX7O1372+mRfXZGcZQkjozW7TnlqqnO9/8Nx8ihY6sOHG7BxU5TZWfFDpg1QvXBQ
        PuGnyo8X3klLp1z8vcoV9HgJyjMjvbjr/FlqQvhC1bY+BsjAC0muf+VhHnzMLw==
Date:   Thu, 13 Oct 2022 23:31:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Joshua Kinard <kumba@gentoo.org>,
        Colin Ian King <colin.king@intel.com>,
        linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1685: Fix spelling of function name in comment
 block
Message-ID: <166569636076.1226796.12100183442618542450.b4-ty@bootlin.com>
References: <20221003153711.271630-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003153711.271630-1-colin.i.king@gmail.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Mon, 3 Oct 2022 16:37:11 +0100, Colin Ian King wrote:
> The function name is missing the letter 'd' in the comment block.
> Fix it.
> 
> 

Applied, thanks!

[1/1] rtc: ds1685: Fix spelling of function name in comment block
      commit: d73d66c0e05741b35b7398e647b8c4f2aaea9b09

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
