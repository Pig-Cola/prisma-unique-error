-- CreateTable
CREATE TABLE `Foo` (
    `id` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `value` INTEGER NOT NULL,
    `updateAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Bar` (
    `id` VARCHAR(191) NOT NULL,
    `fooId` VARCHAR(191) NOT NULL,
    `stage` INTEGER NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Bar_fooId_key`(`fooId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Bar` ADD CONSTRAINT `Bar_fooId_fkey` FOREIGN KEY (`fooId`) REFERENCES `Foo`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
