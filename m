Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364C2DECCC
	for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063567; cv=pass; b=FCqiZmuQBQ2L7niMPax4gYDQLOfZaDccdHeg2aQgA77sAI/+N272oAB9SZlZdOffefjm0iYWrdjfVN9T8H3rfLbc2Dsz0sAYCiMZnQQjml7f1lT8NfpluWhFIcXfd6twNbM5Y+1cB42kmgosUd0BlDqD09Awk4l4NM4/pDo+IvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063567; c=relaxed/simple;
	bh=NGssG08XGVBBqY+9J7nJH2PbzBb8vv1nnvneoVYMMxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFljKx7RfUgjGN3hOaq/1eOwl71jj+dGDP4nCc/8i/RFmddWZ9SAhJ058e4qZsC7kT1erfUDalGZrw2S5xaKla2tD5bdkQUUj7WJTeol7wEinS+AafPy9BUcKtiaqd/MgJYVyE/4RyFiuFv/nzDM+ggL6Dbu+vpwrcw89MmhKdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g689A6Pd; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g689A6Pd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956242332dso49480895e9.2
        for <linux-rtc@vger.kernel.org>; Tue, 18 Aug 2026 07:32:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787063564; cv=none;
        d=google.com; s=arc-20260327;
        b=gDdQP6qZRLnmzfS4n0c6Km2z+23cKc3FOa/HA8YZRW9Pko39Waq3qVRnxPtiAfufWr
         Wn92+XiiM/8WDEj3AP++uQ53M/OSeASnG/mSnq1FGrSB+aC/ApVW4t5mjI62o0lDIWmz
         N+XoHVRJYTmwpy8Onam68cIDhkotS7nj0DG83Kazxc0xdVKv0WK1u82ESEzpEKxtbA/o
         EgNFU3N1REPH5TNH3/zZx9Ia087q8FeyzeRJX/EWvsmaU0Bf8hYzJDw2UvZ2LAEmdRRP
         JKxUa/1UyUNnk3SdZz9Zq1ZJ/N9MaISo9gTFtnxpaZ73o3J1cXpVnW5AS7kkzt2T4qwb
         +zVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NGssG08XGVBBqY+9J7nJH2PbzBb8vv1nnvneoVYMMxM=;
        fh=SAv7J9n0pZh7r6eQ4crt3M5AeFeNE+djR2WfyJmZgCs=;
        b=ReWVszY/8Um195nntvGAVbj3jNEwKGt5bfvgw7tCzOTY4ff/c5i8mbY4dpj7zkvh69
         b25/kat4qNb+wgjZG+znD8qe5qO0JCNA/jReWvf0SOBevDzvLhuyhh8L86C2xq9/S6Hj
         z8R5vfh7wDfw6AJtX15KvWrBmBn77lY3QcvEXe2MZrL572mWU3CWcmnANXv7z16nOdlB
         EBtBaJmz4Ui+LiMEKQyr2iHa/8zjHq0rNO59OmZwEIWJxBrM1BdvwzEqymh/T8/Q6jrb
         gQtZYgOtHgapMBkdJAr/7Iu1RcvQLDLd74ESJhS4o/S5ugQM/YHg4luC7BxDOp3p3VSM
         Zu0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787063564; x=1787668364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGssG08XGVBBqY+9J7nJH2PbzBb8vv1nnvneoVYMMxM=;
        b=g689A6PdMapd7GVxh/aPAh2PbNs1ore1C3tSh5hajxXUMZK/ps0gDL7WqOobU1RRo0
         4gvZG0oF4tWxyIlfdlvmKCuPKQlqQDH5IvlRvMNZmJ7YQzzo7bX2WsZmFoZqccjBjlqw
         3RyE5sIXZeQDM4qZdQPfNwQZvYIqqIOpPWe1TEjne6BWfD63y+SpVjUjIJF3TKet/m0D
         Wq29VAnvPp94Y6XxE3M6sPZjhxdlGlXYTXUaNIfDkajbnmVRf2G4dJrWvjUsFrMG3HeQ
         4zKFyKyiDMzDaSPVjXjXaMk2irx55X/sKZcWbMvx9Iz8/Q/yY2NyaHhupjfLD89vAr9u
         zt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787063564; x=1787668364;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGssG08XGVBBqY+9J7nJH2PbzBb8vv1nnvneoVYMMxM=;
        b=LoyeElIfj6NLCTHOUw6MAWG3m+dyak4/fVUba4wuYlu92Olfh1q/2FiKCm/njn4ND6
         sOxHzKhCSJ5CZuRSMFeJ0E4w9Et+BaNAs5PMKccQeej9ierRIHk5uIy7387vXKQKMOnB
         ZVyf1bBwzfh+gBYQVry5glvmLrTS0Ty+fBLiswft8muUUKb6ALPe/hyD/YK7cgnSHDaw
         WMmJPqiHaAFjS8e514pY32B92xq5EHwp/6+ZMTxFcnMO1nBrItTgTvfoZPWvTZMZvoxF
         ILWPiskUVtSOc3FE3tfnmgGQvWzzLy3AdxaJkk6pl0ete0I47Xxzu9Q8d5bqJwxX6zy3
         Y0Ag==
X-Forwarded-Encrypted: i=1; AHgh+RoDaL/xfICNNuFoqwI6zGBgZ6l1nM6LGYYmg9MBDfkJQbd87wCKBqgdHISciKCADKFwwInOAFZtLq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuanToghpCp6fc0lyF1RkwEkx9y4K2Y59gTwfV1dHNNKqz6Nw0
	EJ14trAvtzCfbxkMtF8dS4lSF7MoPNI7HOfvTGrXBoK1WbPO7LEI6Vr337eR2mhAKHh2BqwUVUn
	uzLz4lD2LcoIRUAomhD1PkbfrWO7wVChc+w==
X-Gm-Gg: AR+sD13hU9p4mHukBdlmbSwgYXh2rRMGSYJ5blxdjqjfD4NePvmnFF1JK48qRaGB95t
	siZiIERr7jQGk4RrY1Eyc8brL0nMf2Y8IKpwSBmZSE1IyXQ5ZDqkleJcQfk6DPBDsb4wzaijWMv
	dukkTExZ7JGBoAtlQ7QO4BMc5ZuVj9gHmU9CS+5f34S+LloZGSA3BvrZTel4fGWhFm72JqWDpMk
	a4KjFlaK3w9fSWUI9ky6ctDiXatzVR9BST3lFMlA6Doo4zf+PSYNKcALp15dS7PPL/vnOyTPa1m
	Uy4MieYgWGNkGCIVxLR08zeu1pgV1sM/ottBpZAO4cE/df/vmfchZVDZz1UIBQ/ROm0v5eK2/Xn
	PsUN6QoTVTpDV+RORy/JY5mvpzAYVzlhgwAf4OwOTSfjPuOf4peTANplp/0WX1Xg=
X-Received: by 2002:a05:600c:3495:b0:499:873b:471c with SMTP id
 5b1f17b1804b1-4998794fafdmr589623875e9.6.1787063564017; Tue, 18 Aug 2026
 07:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706175138.12587-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175138.12587-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260706175846.7964C1F000E9@smtp.kernel.org> <aoQMyllxMOpY5sHx@ninjato>
In-Reply-To: <aoQMyllxMOpY5sHx@ninjato>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 18 Aug 2026 15:32:17 +0100
X-Gm-Features: AcwNN1VJxq7eVCEWfdNgZl_iK0BuChP1h-uLWAWz1h0QEtggQlEtSfG5vXSv_tI
Message-ID: <CA+V-a8vu6d2mo_zSDLi12gpQa12ag7kUnUWx6E6B1843wOy+Tg@mail.gmail.com>
Subject: Re: [PATCH v3 01/12] dt-bindings: rtc: renesas,rzn1-rtc: Add RZ/T2H
 and RZ/N2H support
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: sashiko-reviews@lists.linux.dev, conor+dt@kernel.org, 
	linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Tue, Aug 18, 2026 at 8:42=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > [Severity: Medium]
> > The commit message mentions that the RZ/T2H RTC variant supports a 1Hz =
clock
> > output signal on the RTCAT1HZ pin. Since this introduces a clock provid=
er
> > capability, shouldn't the #clock-cells property be documented and requi=
red
> > here with an appropriate const constraint?
>
> X5H has this as well but the feature has neither been implemented nor
> tested yet. So, I suggest to add related properties incrementally.
>
Agreed these properties can be added when support for this is being added.

Cheers,
Prabhakar
