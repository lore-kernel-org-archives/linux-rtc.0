Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793640987;
	b=hwx8Q8XFwwuiuv2I/dKCcJ91PXLAHqprNHHxtPjoKkxc+izlSx9EDoC3s/xTzU/5uUvs
	 ei2DOXVVcsQt5pL45yiqekZ5f37Zq6bmeVYvOtzEFIVxAGIxl5ayewwYE2nx/2i/lEMmE
	 c0EyCm8JXAhe9SZPK/BICniVeyX+B0lGlDPxbBm5dRnReYBLFO0/uc5qLrD3tTOUWmnyj
	 M0O3nf5HLcUelxwrbIAY8YTz+qRtxBhsy5sZGgg6gP2SX/Es4W8ph2Di68SNE4kTDSupe
	 Mpkd6Ms+hG+wL+NVjMSEaB+5pMHh5BKMXAWgMeOCZXaKi0s5XJ3zukbevODydU+8DRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=RgAiywsBelbLFo1/0q+f+El0xcDDf13+2s79/Xr1ciw=;
	b=UYXKuLWBc+69sSHUA9IYbH4PrSCeTrXIXiUzAP+eynUFxQr1QHuOdWjiBFJOTe7idvAG
	 0W1p9NHG2L/7LzO8Ev5folfBHKk/QlqOunQhA/qlJeMCBmP3YNlbdSdT1q9LDSUgblswA
	 0tN59h6JDDR8xSvRcbl9sE2/orlHRufsjBDuxAXVcxdryv0b/4/N7/m0IoW+ajmcP7pud
	 io++8CMOEdBBSothMflpgAH0EiiCTfM8oy6ksL016pZOnMVB9lIR6Pm7yCOoHapgnxKOE
	 Z3bkAW8ZbF9U7FHvSARJkBh+MP40P2CWgKr9c8VVrLxn97+xPJSpBg5ALaYcPGzbs0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfAVi5Mu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252916070390
	for <linux-rtc@vger.kernel.org>; Mon,  2 Nov 2026 17:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 252916070390
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfAVi5Mu
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c468bd799ecso408300666b.1
        for <linux-rtc@vger.kernel.org>; Mon, 02 Nov 2026 09:36:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793640985; cv=none;
        d=google.com; s=arc-20260327;
        b=cXH3aVSpOROlfnFhXbGo3dMkBUw9kXqgatwbifG/Foyrs6VuyBL5FObAXVBSkNzqG5
         t1IyczahTp0Abi1Z993c3Wb1foNns+dIZTT6S/MtNGk/AeitVyerI9hgQ6qICgPP7WUt
         j8+0hSZpECXSeqfKfhV9/aEBMA7LpRuZnd5YArpXdJvVA2mlB/jkl7nHX97ldXyWTLNq
         iyLDRVSOqKvXJj/Z+Wj58iwcQ1Mc09/RDoyxf967xF1YNw0wx/fiKQoMwfjbInE98xtK
         QWHmkQ6X1o2Q54/MlJXBqvMIkY5RkdahhsAFd1rlRnT0dO8P9Colihu/XGoABZffeuxX
         EiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RgAiywsBelbLFo1/0q+f+El0xcDDf13+2s79/Xr1ciw=;
        fh=2jOKjP1TNLVlw4PfVR9ETrWSviO4D30QDmciw9D7Tfg=;
        b=IFdNOrI7x2sj/h9gC4rTYz8lnlQg9DsAObKSg6rQmziWKu22TUuIGZUvBjvRE0i4Vx
         T3xmZZykYBB7GghTfuIo7thpkFnXrSuFMpac7hqRWCo+V5sNIW8Axd9RoPCgUssgTv1k
         ooqrlQFrxerf2twlgLQW4vJCL4IjSZWduSbd4UOeClaEA6urbdY7w49YN3xIGO8s6SaT
         edIIrkxtLhumQO6nDXo7A4tGErtc1MnlXIW84Mw98yFppL8h2b3vuwRHzoX1JH2QFiAx
         Ogmd/gxityw0JYoWaLkdxHFS8NzuzmBt9y+gDY8T+GeIQJd61xqI0Z2ygsu2os1LI+ag
         ZF1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793640985; x=1794245785; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RgAiywsBelbLFo1/0q+f+El0xcDDf13+2s79/Xr1ciw=;
        b=tfAVi5Mu1qxxARcUhlcBabXV70oj07RD/2gvRpDVYc65ysF0zYdNhPrZKQPmsTjQSY
         2K9EeHbPpq+ZweX3RD1E1P/S3hn2rSGt9NWbr+AeaU/pgzrchOzTrDSHXKwVE0Bz2/m9
         JahZbq/GKj+LZZEG8LFhy9FhH2x7bVOTDgW6uCV0v/ikrrJEV13NPoD2oBmQE/KUdDLG
         ZC6gxE+OW/EIcLVZnZHfi6iFF3jkXpfkO+k5iiM1IxUU5P/5cmbaoJqVmI763YvtyC4m
         /BOOYwA69ZCEHPXxDtzPv8HPZWH8+CY23WecFJrX/H9FKEcTCbK6PJbWz39JszHb7k62
         GpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640985; x=1794245785;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RgAiywsBelbLFo1/0q+f+El0xcDDf13+2s79/Xr1ciw=;
        b=xiNq2u4fPvuU/8dnVr+ErQ16oC6AlA5NiieJeHvy3Yo/mMbywDN2jTpvh85L0jkrms
         vryFYNYQopv9up8zy1H30d1YRipLEwiU84NHuy17VnNIpRR91B31iLyiNKynkUF6JQiY
         8B3yOwsQE3TMaXk95a9U95r10TjDK62nezvZVqk4/vQ4fPQCLeMp6Qwi1wG48v7AVJCA
         XyAjZRIeod1dpK9f7cUoYUJeMq4G98hLJCHleJGI/f8WoFlpMSIXf8gWN3nzSZuTbzkV
         o9Nxh1VMZ+pI/2ScT/KhFkjDH04+NkcXqicGRHSlTnkCqPceqtmk0EmeprD6ovSkKVUT
         OO0g==
X-Forwarded-Encrypted: i=1; AKwUvByy4+nmnNaor68YZmrz9HzJashlnurLEE4M9RBAkmGFwccunWToX9yPoR+FpXEUEi/wL7SyF1m27qE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+v0hFd7LoOx+vBXtlfDWp0FALJusmYtCoosni83nq4qiaNubtr
	O6PpaYlmbNDUT3l37MUzuXeznvnXTitqassjuW8z9duITOhLb04MNWgXKDiDqC9DLqJREiSR7os
	iWpOiDd8I8QuKRbbYA4voewfRyw5AklI=
X-Gm-Gg: AYBFou3LK7z9MhA9kTTC5RGDr/JKl0vD6tgDH7wLjPIgWSOlycoG2vTFuG6EnU63JeR
	OW94/XLFCibwVMPk7pABW6/saVxBTC8X+Tbtwd7pZCg2y+FmzThPnAepCaFGTrzJRV0ZopHoCOy
	eE1E72v1SsDoFVXOBQn9tL8mD1jKj3pRL5cK7kp1O82q4CQi3z5C2xZGiG7hEdOSTNaTPQcqwze
	oO37G3s+i4+yf9uq5yjoIG6K9id17Y1xqGa4rqMVvGPar1pMvB1aP4mcALyAf3YmecdEfDuJx/7
	o8YFDh+ygQPtjN/VfcXx3DvzJeZpQVNVEwV0XPrD1qZ+YxHgo5+PSxJGe56lrsXmT/8k4HuAMZ3
	K9NKiWpykDJxDyQEA4nEbZhiKRbKvtFZuCvISUi7I787cDqFQK9naDpI0
X-Received: by 2002:a17:907:6d0f:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c4ca7a9ef61mr913462566b.35.1793640985367; Mon, 02 Nov 2026
 09:36:25 -0800 (PST)
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102170227.1719206-1-pbrobinson@gmail.com>
In-Reply-To: <20261102170227.1719206-1-pbrobinson@gmail.com>
From: Sander Speetjens <sander.speetjens@gmail.com>
Date: Mon, 2 Nov 2026 18:36:12 +0100
X-Gm-Features: AclHuK-CyDEaCXVZkgO_fdjPqIxjUfqHnveWflDZ6jueAfoJaul35aOiuTuRmYA
Message-ID: <CAAOJLPH92mu4cbpRCvKrDnRtscW3XjYHvpWZ6xkCooreQMpETg@mail.gmail.com>
Subject: Re: [PATCH] firmware: raspberrypi: Add bcm2712 revD compatible check
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 18:02, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> The bcm2712 revD doesn't contain the base SoC compatible of the revC
> because they're not fully compatible, we need to check both else we
> don't match for newer devices and the RTC doesn't get enumerated.
>
> Fixes: dba67294e2151 ("rtc: Add Raspberry Pi 5 RTC driver")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Sander Speetjens <sander.speetjens@gmail.com>
