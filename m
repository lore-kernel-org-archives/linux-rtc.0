Return-Path: <SRS0=3NBh=SN=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE01AC10F13
	for <linux-rtc@archiver.kernel.org>; Thu, 11 Apr 2019 13:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE67217F4
	for <linux-rtc@archiver.kernel.org>; Thu, 11 Apr 2019 13:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+rqHzwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDKNir (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:38:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46143 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfDKNir (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 11 Apr 2019 09:38:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id r25so4707051lfn.13
        for <linux-rtc@vger.kernel.org>; Thu, 11 Apr 2019 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E36OFR8CxgH13e701yYmWUl4SOEDNsmJuaGF5YN2y2s=;
        b=i+rqHzwoRZVuWLdV1Nmq/Um9BbqFu6GYetiZuBdcjM4kkIWzp4eT7hq0DwIVMhi75T
         ATuO2PWb+Fshard2r8I6WOBtbFtZW7qYUZ6UGc/GBCqEDdVn1npLzdRA6hZlRdtqimhc
         I0FoRkwi27wHO2ZY7p/lbRlcSd7vbW7PDSjKIWEfIcqaYfA0j1WS4Pyc8O/wKKgPrulC
         asK2l/3W6Pcn/VZwwXKMkgkbJBRWGxKWmJQHqH3kEG/mgCGbzNY1llLCeQRVqujHOyUL
         xx3d88mgLDpN0ObMSSo1sbK3jADzLjZH9FA9fJ3l5PNDYz+egoHJYxANHsAEV36iWB2L
         dvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E36OFR8CxgH13e701yYmWUl4SOEDNsmJuaGF5YN2y2s=;
        b=NE65tTHd96x0GjA5PgZeHKy7qcEV/hLDY+BAkL4ZSaN4a5mQEeCioLpMa0Tn79Blpe
         6ePBWpDAaxPcClUFQ153wtRwmp3EJvvdoHrDUmJnQZ69jd/H0l3DjXGYb6KOdDOOgVV9
         Oio404xFHfhHKl1np3aEzAqg4ScVP4Kfc9la2xUKTsMksQIw53B68tks0G31P5u0EiK7
         n90nHJlLuMDmrkaVdv7FgWWMt+OBt4B0LYnu/jigvqibWqCxl+8HpnHfUTk+n3f+Qiy7
         WKL1l6fadJRD2xE7MUyaaOkbP9og2iK64dJ68SbCrYnr3RzwiARB9gckSSHcj/eaWD4z
         MFJw==
X-Gm-Message-State: APjAAAUwl8FABe+PjY7TEk3VCG9M3HrXRzaF9Ec8WycNt67RgbKV0vmG
        6T84opc0Jr7cxt6lvi3Hcl3EcIUlF33CkEfQOEEtrg==
X-Google-Smtp-Source: APXvYqzvEjC/5vkC8/9hFjBrPjvVEuFSo1c858ZDcqzgun9rcYddQXH0tqK22YZjrRIz9a1XGcCfnxNOEq59AUNLf/I=
X-Received: by 2002:ac2:546c:: with SMTP id e12mr15596737lfn.121.1554989925475;
 Thu, 11 Apr 2019 06:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190409195945.20725-1-alexandre.belloni@bootlin.com> <20190409195945.20725-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20190409195945.20725-2-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:38:34 +0200
Message-ID: <CACRpkdb4P_8T5Yf18cThq09SwBbvQMk1Qs_VZZGf45UbHfFy-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] rtc: ab3100: use .set_time
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, Apr 9, 2019 at 10:00 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Use .set_time instead of the deprecated .set_mmss64.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
