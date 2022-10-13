Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606EEC4332F
	for <linux-rtc@archiver.kernel.org>; Thu, 13 Oct 2022 21:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJMVhd (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJMVhc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 13 Oct 2022 17:37:32 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DD83D5A1;
        Thu, 13 Oct 2022 14:37:31 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8E72E20003;
        Thu, 13 Oct 2022 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665697048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vWeiKqAx7gftpua/TdMMpv/XZQI9W+JnaJ4m1r6TPPI=;
        b=jExKrPpE/iI+xjhe+ycCsnjXKTW85zKoELCVGAP+eTmr4Mg5sxm10rgm38JgsJSyFKaW3g
        GMVXZDI9SaCkVzuLlY+m9rhtUgAZ7fWHEQcTeanPgYhQOwJPzTndqE6ePswqZb/FvDEXzK
        lTdHASn04+MZkajV61DvBc6T+YNdtf73HEJ1ee7WxO0W2jssTY9l008b543JE1WRWdJYV3
        eQkktGOZtRFS3WulDE3HzXJ6KbwRcb3OlOr+AzSPqPDMPWV84pwzqjs3z22reCgFV0Gize
        Gjkg9r0V1VJt7fxEbzKPsXd81GLQNxCjDrYnh6ObGkTOVL7aqFtio0iiHvuuOQ==
Date:   Thu, 13 Oct 2022 23:37:27 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, Ke Sun <sunke@kylinos.cn>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     k2ci <kernel-bot@kylinos.cn>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] rtc: rv3028: Fix codestyle errors
Message-ID: <166569703391.1232375.16439218029438557836.b4-ty@bootlin.com>
References: <20221008071321.1799971-1-sunke@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221008071321.1799971-1-sunke@kylinos.cn>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sat, 8 Oct 2022 15:13:21 +0800, Ke Sun wrote:
> Compiler warnings：
> 
> drivers/rtc/rtc-rv3028.c: In function 'rv3028_param_set':
> drivers/rtc/rtc-rv3028.c:559:20: warning: statement will never be executed [-Wswitch-unreachable]
>   559 |                 u8 mode;
>       |                    ^~~~
> drivers/rtc/rtc-rv3028.c: In function 'rv3028_param_get':
> drivers/rtc/rtc-rv3028.c:526:21: warning: statement will never be executed [-Wswitch-unreachable]
>   526 |                 u32 value;
>       |                     ^~~~~
> 
> [...]

Applied, thanks!

[1/1] rtc: rv3028: Fix codestyle errors
      commit: e5f12a398371280649ccc9d6eb0b97fd42a5df98

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
