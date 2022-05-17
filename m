Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A2DC433EF
	for <linux-rtc@archiver.kernel.org>; Tue, 17 May 2022 22:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiEQWS4 (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 17 May 2022 18:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiEQWSz (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 17 May 2022 18:18:55 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBCD3BF9D;
        Tue, 17 May 2022 15:18:53 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6BE4F100003;
        Tue, 17 May 2022 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652825932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RU+TnHn7PAKyWRHQ76VYEGCSfBI3trWV5aXmLI2KXTM=;
        b=CLfhz2xtHdAMN0iwmoVMyf2weSgH0fO1bsOW6e36MpD8Lnn813hefcT20TVNP+d1MgDUxt
        /bwGmO6CR+g+jfQ0mETE7eaESekBQtGchSuDaK/MDGZRcuK3YYn51vVAgVL1rjrcUuhB81
        fi3T7ScY0EbJrXlz9L/APczegKSRb7Vf4OSiDmmxrEYTcZ70+eXvctAR9E0XnuE52Wr+ge
        F048m2cJfMguW3R7NmuBU12zKDOSuE+d0gcJ0IETlD8Pf1f5HHg6zdtyTkIAv0XuVVNC0J
        Qo4TVTqPoedjQtd1Y5Cy4+WHSzWS9aCQFYaNrrEAkIlZGz5R6laOwLuBHiai/A==
Date:   Wed, 18 May 2022 00:18:51 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] rtc: simplify the return expression of
 rx8025_set_offset()
Message-ID: <165282590997.294391.3805393279220987607.b4-ty@bootlin.com>
References: <20220505022314.59822-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505022314.59822-1-chi.minghao@zte.com.cn>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Thu, 5 May 2022 02:23:14 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Simplify the return expression.
> 
> 

Applied, thanks!

[1/1] rtc: simplify the return expression of rx8025_set_offset()
      commit: bce7a01ada6456d00c69cd816357ded268ad780c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
