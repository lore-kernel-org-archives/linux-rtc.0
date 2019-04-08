Return-Path: <SRS0=NKr3=SK=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA155C282CE
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 09:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1D620870
	for <linux-rtc@archiver.kernel.org>; Mon,  8 Apr 2019 09:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSZE9Ui6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDHJLA (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:11:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41264 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDHJLA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 8 Apr 2019 05:11:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id 10so8895181lfr.8
        for <linux-rtc@vger.kernel.org>; Mon, 08 Apr 2019 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knCIHqOSCy6Gb+ywFDrlCvuMwcxt5qtF6l4vOq1t5FM=;
        b=NSZE9Ui6b3Iis22/fDtn8JCFkt4fBk7BO4y1lPBqyKNzp3gEXZ2Layh0NnpOvKt5Kn
         jDpWJORhLPR9nX3BHOSQlIKnW1yywDOAnArTMYUOvdAjSMvtZVVkA6XZVdKgsksGOuuO
         4t3uN2YkpA/jzW0Bj2VWdgAWukq/h6iy6TxUHzQaZJcqvVl1/4yD9KmcwKSqYteTipq8
         t4wc/Icon/8OmTTMvag+UVz3hgU/MbgQRwQQuSkpI/kchXKOpuRGEwdLYb2rH8Q+87/A
         D2zcsiAuGg4e+Z33JbPu8hWnac6O8GIchQj5P0McK4P2zjOXOnt8GScAAsczfpOhIL9+
         s6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knCIHqOSCy6Gb+ywFDrlCvuMwcxt5qtF6l4vOq1t5FM=;
        b=jhfmsAA6SB2xTYXNejyQeek+9tXOkpVFXmHkDgVUNI8Y/UUMat1FQsusXol4qXtB5c
         86CJigYQ2P+3EfpqEDLUc7NxUpTqXEn9aHL+lzw5BXznrjA3ZSZaF0UdEeNfvyOu94Bq
         xdDkhMowBtEKqHOYL/30yCyaFHydHa0JN9WhLaclJPW3bTfEzU68lz1SZ8iQ6jg6izJI
         YCx1GgLR3oiqucYfF6CKSEjOYbNaD3ODntQrMUrm3UV6A/bpqnOoFPM4Isgs4z32qIE8
         FErQamROUqdwX6+IbOdmI0lSYlkpP5q4M8V93621z2V34y7JA6MVcJ44/seF+1eVHto4
         U37w==
X-Gm-Message-State: APjAAAWBelFM/ux/lQL3iGv847ZdrjppIbcNpPkYGL3UzmQkGW17k7Ym
        VDGEd01o05aOUAq31Z9b9ufrAtz5FQwPBsTBaReh4A==
X-Google-Smtp-Source: APXvYqwHHGeAwRwclgpMfaJogjd5gYYg5mzN5HDkwUqbIVTNaZ3YTjnpv6mtNxCPH+oQIr8RvGCizl6HMDmERJT9IzU=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr3887892lfn.121.1554714657992;
 Mon, 08 Apr 2019 02:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190407211027.14012-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190407211027.14012-1-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 Apr 2019 11:10:46 +0200
Message-ID: <CACRpkdbGhTjFffm7Co6YEBRm5CfTdOTTHFsxH32Ybcp+P-F=rg@mail.gmail.com>
Subject: Re: [PATCH 1/4] rtc: coh901331: set range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Sun, Apr 7, 2019 at 11:10 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> The COH 901 331 is a 32bit seconds counter.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
