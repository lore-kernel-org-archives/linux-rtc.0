Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF911395D98
	for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251399; cv=pass; b=XIf2+2x48669tDufjce4Nr9j0ZNjIP8RPINtC9HNRiuXEMgEjhR4eUiCfw5ZjWmGid5DHDIfPc/GiGWhzaIiCn39Pe4TQbV9V970RgJMf9YPLHms+nZtVeTq567Hy36qtyo2CcZYkD4Ls8+1Sr3hWjv824kptGTmqSomzWWrus8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251399; c=relaxed/simple;
	bh=/gqSU1EwjK2L+OI/UYE3e2zLhINP6ZH5lVx2IhdAMcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEvk8eIA+QcWT8Hv72irxDaF9RL7iGerE05BDj2fWuNGxtMkQexI2jGdcOFyDQSoPOkE4ISgBb4HKlcUHy0oDohn1K3oAtTIo73D34a1H3GV5wU2OyOAFRdK5Deb2v9aEeIHptbMNXLDnNs4H84gK48RZN1EFks5In5lCjE+UWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mj79YdgU; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mj79YdgU"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-472326ca506so161252f8f.2
        for <linux-rtc@vger.kernel.org>; Thu, 20 Aug 2026 11:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787251396; cv=none;
        d=google.com; s=arc-20260327;
        b=Q68aOyF4fJN+CdGlg7p0YXiB8XKy5B7U0YurNPThPIFMwUmZhFhnTQlpK3tdKrh0GI
         kFtQMavYWvic9hyUwzflDqtVelhwcnnQJIsKEfpVtSsAuQY14TNgB+khiKHN2hBoysrM
         gRw2I3a0zsoo9GMSwM8ile44nCu2c6YRYytRm8PMmm7B1eGA95FvByLPty3xteUsUPxF
         Oo4nkr6VrJ6KYL8LEikonIM14zMVSB1WT78VSykjEfAh/+1HADFkpuwjzv7czm7TIMYC
         QSZ6VGGzxqK9NlQ4S3uiqxv196iQz/4yXqCJiec5N+YZ9HdC9Pqe3bqo/YWActBI+8tQ
         WkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/gqSU1EwjK2L+OI/UYE3e2zLhINP6ZH5lVx2IhdAMcI=;
        fh=ItlYTj+WT+cLHYK5cxjeiB60/JLlJaPiPKTgawlmN+g=;
        b=QD/vtcusPCyL62ZKTXqyAE5WOAy/GcjeOvkJpBsv91/druMVwoSs0tNF8HHZrh3yTJ
         o5C6p5aUyTZaZGai0lU76PAPNlbGsM9ZSPCTepV+xIO5T5OL6pbrwlI42TEWPA0Yai9F
         QAhgvrqy8gOUSQ/TIAeUeGAUvVGkHmJ5pB3D6/AP8meGyYiDulSZ8FnLeDv2XDBTmTlG
         I1bu3tTFhb6DcgG5mL6YV5URncoG7bE9fztS9gCdMYlBcSpHhZUErnYoTv6m5/bqqPjD
         //dCY+vu36wm2Ox0jiszKvf8iIat28ql+8PXIknxvMcpjPiNSf2oFvuYOMbZzKBTFl6q
         949w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787251396; x=1787856196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/gqSU1EwjK2L+OI/UYE3e2zLhINP6ZH5lVx2IhdAMcI=;
        b=mj79YdgUNB3vXJAYIveEq0p7HlvflYtmszQNqdt2D5NMVMlCMfE5KfdkGbDqXtAI9k
         buWDJj4cU1jsV+IjSP86OsxneXIXhhv8ozLuiiUrQ5C/zP2ZnxzJ+3ClkwvKQAYx75b+
         5LmgDvshBG4am3sSlVNz9PNV9NWYYuz/E4Vqp56PqD4eK8BJBHutDFGJKMHc6kDhKwT+
         hps2/DZvPqY+be8EaoJmFakYfrh3ZYpbn6JQShxCw4E75/xyXO8gaV71l/+nt8+U95ir
         uNQBTICAnEnO1rwGiLE3hpdgWvHZtT00VU1EzeKMztqe9HegNIIvWpf2Bz6LA/JyOBEn
         GcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251396; x=1787856196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/gqSU1EwjK2L+OI/UYE3e2zLhINP6ZH5lVx2IhdAMcI=;
        b=Wv8ppelLQhbktC0owbSSEvE9iv8eDzUhJ6s6e54CA5L5/PJCXKn0nRPs0lZKB5J71r
         1Mgzy7QUjZ9KDoOKFc3QXA2MdP3v1eF+fdC9VBKI63KMyGU6xvYf8zQGHJQ+6v94WTrc
         +qqxypbfUXsipLfuJCMAHd/3WEbsz7caR9P3wWes6ZTCPxxeQ7GcSrr4NwvGzULZaYhK
         JUFC+dl6HTUVrkOz1rAY3VTwQLs4MUzTHD49ibGHPUFEgYp73ndP/rp0Keszcey2oyhZ
         BJ7KdsOoGzW4P79TcqdjNn8peH4s24dHxnjgOZGYcni8NLd2C+tEEhrhq24yku/0TmYq
         Angw==
X-Forwarded-Encrypted: i=1; AHgh+RqD859fdx1ssvo8aB6uqiaVMA89FZ0y4oUGcT1dEzuhWLsK3tYNyVzUx7FHNdU4AQTebT8I3TFfWVI=@vger.kernel.org
X-Gm-Message-State: AFuF++miXKlsvWWxY5NzvU3e0bp9D88rG47+1XZZWZL9NWnYb4uSy//M
	9z6s23vxdEpGQWUP5NrIpDXuw+wbe1xekgrvlOteEtiKqCBvtlQyV3ytRj3IkKuaUoEtc4yeafk
	S61aRwUNtfPSLG6Cxtk6BQyvIHFrkXsl8pC/a
X-Gm-Gg: AR+sD1004LQoLFHYcdPwN9uCwOpgQDdUiy8PN/jMiv3AV3kvL4vAb5IWt5nvNlFkLtU
	QEFFtcLTA40FNs1XrexOm+1/38NYbi/FBpIOC+YpwevZbm6j9swKEH7rnYUvhgS3BNYxcmfeyJz
	2y75lSXJ2Io531YNFQraF6TxJ/tRaTgh04++/ddb+T6yIZPkZ09t0hDODzKtkKJTFmZZPttyVEc
	OPx10zFYFepXpqY3auGNa9a8eBNMBU9oYtn3U3lY7LPlOIPr62aWdqnWe91c28WyV/VCupiyx7X
	OOVfrSKAmEeoifUUchDqIYXGHbpBNFv+QhqlbdMA83hKG3sj68Vx5rIquGq3qBOE6TxBu/E/CjV
	csEJI8+OUxUk/1VjyQ31sJ5ujEFShvQ==
X-Received: by 2002:a5d:64cd:0:b0:482:b886:4ce7 with SMTP id
 ffacd0b85a97d-482c0b95967mr1559704f8f.12.1787251395978; Thu, 20 Aug 2026
 11:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819103926.2136712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819103926.2136712-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260819105027.B7A121F000E9@smtp.kernel.org> <aoWqVMc-EQEDqA8h@shikoro>
In-Reply-To: <aoWqVMc-EQEDqA8h@shikoro>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 20 Aug 2026 19:42:49 +0100
X-Gm-Features: AcwNN1VWAd4yRx74uvdrwkqeGxUaWBMQRHelzjfY8vzM6hoPGzX-UUqIL14Hd8E
Message-ID: <CA+V-a8ug6svy-mWkffaZxN08+TiczPk4mq=aqgavnHdYebaVpQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] rtc: rzn1: Replace remove callback with devm_add_action_or_reset()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: sashiko-reviews@lists.linux.dev, devicetree@vger.kernel.org, 
	conor+dt@kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	linux-rtc@vger.kernel.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wolfram,

On Wed, Aug 19, 2026 at 2:06=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Would it be safer to use pm_runtime_put_sync() here to ensure the devic=
e
> > reaches a suspended state before the teardown continues?
>
> Yes, seems like patches 7 and 8 have to be swapped simply.
>
Ok, I will swap it.

Cheers,
Prabhakar
