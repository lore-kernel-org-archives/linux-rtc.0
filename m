Return-Path: <SRS0=3yQ8=CK=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A364C433E7
	for <linux-rtc@archiver.kernel.org>; Tue,  1 Sep 2020 17:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9347206FA
	for <linux-rtc@archiver.kernel.org>; Tue,  1 Sep 2020 17:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oORaDJmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgIARFN (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgIAREo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 1 Sep 2020 13:04:44 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D91C061244
        for <linux-rtc@vger.kernel.org>; Tue,  1 Sep 2020 10:04:43 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z25so2033266iol.10
        for <linux-rtc@vger.kernel.org>; Tue, 01 Sep 2020 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=oORaDJmQPxHiuYFgNBxK2kTEoAFb+FdSxsBw5+rCWsIBm82Sq2Pdb0pvVChG0+ORAG
         nsEFMabBfS8q+2E00bywXhzTfan0Qz8gwvys9mY2m4LFTpEuWAgT+qI75HxdbAYji5MA
         rRR7HKJiO2BX6Sf9vFbdHox+aInog5LXNMf3wVvEgfRjJPXyRieK559Id/vw/TqRcqFc
         4nI31qfWT8tioC+x1rULlNA3QSretq8vfZiojmIObaiFeJ7EFEw6NOxTSfArpYcrAs1R
         xQtYjJXqFKssHm8VvcLdyoQ7j0/MpqcXOQhRQzP+k0U+CyWpR1MhDUbM9x/ANG6Vgd0P
         5C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=Wbf4i63YAufhXzPaJwv/rGQkaNccfpgaDa/Xhc9cdpq+dQIr5LREN9zgW6iXUI9Eh0
         qUtEYCPRNz6I6oOmegsdC5uq3eqEDnvs3uC1VmPvYntG79NQnAjbI3iuO1xep39T3F2z
         e11IjwQV/RUA5lq073NIM0FWEYAzriw4cKbQ+qh7g2gd3TxBG33icok7PqB6pC9+PLlo
         RsJwU5SJvBF+3Mzkw1iT64RtBA5e8m+E21jTVncXuqaQKb06HC3dxasWJIcrVR5tL+XH
         +9OkXkFxVIIPPCnZtyOP21igQjn1TS4FCHJuWfvnDeE66RvtK+3uN7d7vy/SKResX2Jc
         ErmQ==
X-Gm-Message-State: AOAM533qwt9pSI1ZS1V2ze3i1tQZahDfe0i8lOX6XOdIB4QcEKsG+qLh
        SbTNza/+HFhcMdZldcLs6nFOiQlkCxr+Nw==
X-Google-Smtp-Source: ABdhPJxkAafVkdV+Ap/HucMD6Q9HY3vUlHCDSBvtUz6JHCzMgoEDix7GElM1EoQiOZadY6unzUJ2Yg==
X-Received: by 2002:a02:93ca:: with SMTP id z68mr2236272jah.3.1598979882700;
        Tue, 01 Sep 2020 10:04:42 -0700 (PDT)
Received: from localhost (46.sub-174-255-2.myvzw.com. [174.255.2.46])
        by smtp.gmail.com with ESMTPSA id c7sm794578ilk.49.2020.09.01.10.04.41
        for <linux-rtc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 10:04:42 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   offline mix <colehargrove081803@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 1 Sep 2020 12:04:40 -0500
Subject: colehargrove081803@gmail.com
Message-Id: <1E25E227-448E-40AE-9FA7-E432C874F094@gmail.com>
To:     linux-rtc@vger.kernel.org
X-Mailer: iPhone Mail (18A5342e)
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org



Sent from my iPhone
