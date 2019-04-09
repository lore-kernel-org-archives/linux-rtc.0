Return-Path: <SRS0=ZSCd=SL=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77578C10F0E
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 14:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACE12084B
	for <linux-rtc@archiver.kernel.org>; Tue,  9 Apr 2019 14:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7TbvzrA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbfDIOfk (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:35:40 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:34881 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIOfj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 9 Apr 2019 10:35:39 -0400
Received: by mail-oi1-f177.google.com with SMTP id j132so13747067oib.2
        for <linux-rtc@vger.kernel.org>; Tue, 09 Apr 2019 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtoXPcj04ftQ4Tf8hm5nRUT1toR31d9B1kNHVq8/Vdo=;
        b=o7TbvzrAKwii2tHi0tG5kyJw4pnnhwH3/H2/PDWFMhsoNyXBLATTzDCIYwBozRmiye
         pXtoJUYXqe/25T8NJJWH0I/eK1amicsM2g1LKt70dJcjL3A4TMvyaSaDaEWdH4I1H63Y
         nq9vA3Ku0eTL2MoIKEq91YJ18hJi8VzpOyaEuezcDmq0NhTcTa6g9KoqgpLAJ2fToTMR
         GLTTOinKa44kKcUxB5ZA3DYm4FhI+Sz+UJntylADwWokWo2ZydJ/R6MgUjJ+t6IfIGKx
         5dWacDPrbHSsQ3C0/Iz4MOrRjmO941z3D6Qn8XFvBB8WfTyezwnadWoTYuS+Fr4bdTQl
         BelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtoXPcj04ftQ4Tf8hm5nRUT1toR31d9B1kNHVq8/Vdo=;
        b=oynjUGsmtRe/sz9Mx4YTvwmFP7OIOmHELwwVDdlMJ2WAX6sTLKG6vt7geV37gmaINB
         PkKhjNUKXmTFmkDLeoOeadxlPSgPipehGHdrUBh7rgc22aW4/zxC6rXCSmfamST8M+4U
         V7iv3k5kzCJeusvxKrn5XZ2RahXT514K6/O0VVI02whgku7VgWP99v2+lc1UW0pPsahG
         UQ3ufX4TOmYt8h3iisbwZPccfIlCNzhHuVF3LcuPiNip0arsQBgWK3RAd8IXTAPinzXS
         pkMPGi2gycsBLCg5Fu1tgcJXvXMMdxyMUaf1/fjl7MY8JJ+NXFn7t0TKSaDLcMNLZpyg
         l1cw==
X-Gm-Message-State: APjAAAXjDMNd0594fY8ft4PvmggSCMkZcZPomqLMT0673AeStxpElgkP
        HiOjdKbJzzR/HCD8wgxdD/KdZ/j30r3eSlAnjkE=
X-Google-Smtp-Source: APXvYqz8gLfs+TviEpOkRcfbK55lNVnk7oRQuqZv8q60kmNfTzgPikU01DsmcJIgY9arKQ17KdVIpgbZKW5RHrxKmqc=
X-Received: by 2002:aca:4f12:: with SMTP id d18mr20734917oib.136.1554820538711;
 Tue, 09 Apr 2019 07:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <CADjOgT97-8PM1=Nm+Mk4jw_8vzt3i9KXUohDAkUsptxS7JuU6Q@mail.gmail.com>
 <20190409090119.GT7480@piout.net> <CADjOgT-BK2SyoZD76iLj-fYG-7-2G0SvkFC4M6zakQc+7Q3g_w@mail.gmail.com>
 <20190409112754.GU7480@piout.net>
In-Reply-To: <20190409112754.GU7480@piout.net>
From:   Mastro Gippo <gipmad@gmail.com>
Date:   Tue, 9 Apr 2019 16:35:29 +0200
Message-ID: <CADjOgT8-C+6WO0Y9c2bDJJhTcpMkKozcru0SuWOEO_Xa6v5hyg@mail.gmail.com>
Subject: Re: Infinite loop on edge cases
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Thanks Alexandre, let me know if you need help testing the patches
when they're available.
I can "simulate" various failure modes on my hardware.
